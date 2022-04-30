//
//  CardViewModel.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/04/28.
//

import UIKit
import RxSwift
import RxCocoa
import Unio
import PKHUD

protocol CardViewModelType: AnyObject {
    var input: InputWrapper<CardViewModel.Input> { get }
    var output: OutputWrapper<CardViewModel.Output> { get }
}

final class CardViewModel: UnioStream<CardViewModel>, CardViewModelType {
    
    // MARK: - initializer
    
    convenience init(searchRepository: SearchRepositoryType = SearchRepository()) {
        self.init(input: Input(), state: State(), extra: Extra(searchRepository: searchRepository))
    }
    
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        // MARK: Inputs
        
        input.searchButtonClicked
            .withLatestFrom(input.searchText)
            .flatMapLatest { text -> Single<[RepositoryInfoModel]?> in
                state.hudShow.accept(.progress)
                return extra.searchRepository.populateRepositories(query: text, language: "Swift")
                    .timeout(.seconds(5), scheduler: MainScheduler.instance)
                    .map(Optional.some)
                    .catch { error in
                        state.hudShow.accept(.error)
                        return .just(nil)
                    }
            }.subscribe(onNext: { items in
                guard let items = items else { return }
                state.repositoryInfoModels.accept(items)
                state.hudHide.accept(())
            }).disposed(by: disposeBag)
        
        // MARK: State
        
        state.hudShow
            .filter { $0 == .error || $0 == .success }
            .delay(.milliseconds(700), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                state.hudHide.accept(())
            }).disposed(by: disposeBag)
        
        return Output(
            hudShow: state.hudShow.asObservable(),
            hudHide: state.hudHide.asObservable(),
            repositoryInfoModels: state.repositoryInfoModels.asObservable()
        )
    }
}

extension CardViewModel {
    
    // MARK: - Input
    
    struct Input: InputType {
        let searchText = PublishRelay<String>()
        let searchButtonClicked = PublishRelay<Void>()
    }
    
    // MARK: - Output
    
    struct Output: OutputType {
        let hudShow: Observable<HUDContentType>
        let hudHide: Observable<Void>
        let repositoryInfoModels: Observable<[RepositoryInfoModel]>
    }
    
    //MARK: - State
    
    struct State: StateType {
        let hudShow = PublishRelay<HUDContentType>()
        let hudHide = PublishRelay<Void>()
        let repositoryInfoModels = BehaviorRelay<[RepositoryInfoModel]>(value: [])
    }
    
    // MARK: - Extra
    
    struct Extra: ExtraType {
        let searchRepository: SearchRepositoryType
        
        init(searchRepository: SearchRepositoryType) {
            self.searchRepository = searchRepository
        }
    }
}
