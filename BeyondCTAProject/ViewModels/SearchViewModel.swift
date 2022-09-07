//
//  SearchViewModel.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/08/24.
//

import RxSwift
import RxCocoa
import Unio
import PKHUD

final class SearchViewModel: UnioStream<SearchViewModel>, SearchViewModelType {
        
    // MARK: - Initializer
    
    convenience init(searchRepository: SearchRepositoryType = SearchRepository()) {
        self.init(
            input: Input(),
            state: State(),
            extra: Extra(searchRepository: searchRepository)
        )
    }
    
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra
        
        // MARK: - Inputs
        
//        input.searchButtonClicked
//            .withLatestFrom(input.searchText)
//            .flatMapLatest { text -> Single<[RepositoryInfoModel]?> in
//                state.hudShow.accept(.progress)
//                print("DEBUG: aaa \(state.optionLanguage.value): \(text)")
//                return extra.searchRepository.populateRepositories(
//                    query: text,
//                    language: state.optionLanguage.value,
//                    pagingOffset: 1
//                )
//                .timeout(.seconds(20), scheduler: MainScheduler.instance)
//                .map(Optional.some)
//                .catch { error in
//                    state.hudShow.accept(.error)
//                    return .just(nil)
//                }
//            }.subscribe(onNext: { items in
//                guard let items = items, !items.isEmpty else {
//                    state.hudHide.accept(())
//                    return state.noResults.accept(())
//                }
//                state.repositoryInfoModels.accept(items)
//                state.hudHide.accept(())
//            }).disposed(by: disposeBag)
        
        input.searchButtonClicked
            .withLatestFrom(input.searchText)
            .subscribe(onNext: { text in
                state.hoge.accept((text, state.optionLanguage.value))
            }).disposed(by: disposeBag)
        
        input.optionLanguage
            .subscribe(onNext: { language in
                state.optionLanguage.accept(language)
            }).disposed(by: disposeBag)
        
        // MARK: - State
        
        state.noResults
            .delay(.milliseconds(700), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                state.hudHide.accept(())
            }).disposed(by: disposeBag)
        
        state.hudShow
            .filter { $0 == .error || $0 == .success }
            .delay(.milliseconds(700), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                state.hudHide.accept(())
            }).disposed(by: disposeBag)
        
        return Output(
            hudShow: state.hudShow.asObservable(),
            hudHide: state.hudHide.asObservable(),
            repositoryInfoModels: state.repositoryInfoModels.asObservable(),
            noResults: state.noResults.asObservable(),
            hoge: state.hoge.asObservable()
        )
    }
}

extension SearchViewModel {
    
    // MARK: - Input
    
    struct Input: InputType {
        let searchText = PublishRelay<String>()
        let searchButtonClicked = PublishRelay<Void>()
        let optionLanguage = PublishRelay<String>()
        let optionStar = PublishRelay<Int>()
        let optionContributors = PublishRelay<Int>()
    }
    
    // MARK: - Output
    
    struct Output: OutputType {
        let hudShow: Observable<HUDContentType>
        let hudHide: Observable<Void>
        let repositoryInfoModels: Observable<[RepositoryInfoModel]>
        let noResults: Observable<Void>
        let hoge: Observable<(String, String)>
    }
    
    // MARK: - State
    
    struct State: StateType {
        let hudShow = PublishRelay<HUDContentType>()
        let hudHide = PublishRelay<Void>()
        let repositoryInfoModels = BehaviorRelay<[RepositoryInfoModel]>(value: [])
//        let pagingOffset = BehaviorRelay<Int>(value: 1)
        let noResults = PublishRelay<Void>()
        let optionLanguage = BehaviorRelay<String>(value: "")
        let hoge = BehaviorRelay<(String, String)>(value: ("", ""))
    }
    
    // MARK: - Extra
    
    struct Extra: ExtraType {
        let searchRepository: SearchRepositoryType
        
        init(searchRepository: SearchRepositoryType) {
            self.searchRepository = searchRepository
        }
    }
}
