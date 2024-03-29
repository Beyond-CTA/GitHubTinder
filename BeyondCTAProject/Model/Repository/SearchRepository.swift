//
//  SearchRepository.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/04/28.
//

import Foundation
import Moya
import RxSwift

/// @mockable
protocol SearchRepositoryType: AnyObject {
    func populateRepositories(query: String, language: String?, pagingOffset: Int?) -> Single<[RepositoryInfoModel]>
}

final class SearchRepository: SearchRepositoryType {
    let provider: MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()) {
        self.provider = provider
    }
    
    func fetchRepositories(query: String, language: String?, pagingOffset: Int?) -> Single<[SearchRepositoriesEntity.Item]> {
        let targetType = SearchRepositoriesTargetType(query: query, language: language, pagingOffset: pagingOffset)
        return APIClient.shared
            .send(provider: provider, targetType)
            .flatMap { result -> Single<[SearchRepositoriesEntity.Item]> in
                switch result {
                case .success(let response):
                    return .just(response.items)
                default:
                    return .never()
                }
            }
    }
    
    func populateRepositories(query: String, language: String? = nil, pagingOffset: Int? = nil) -> Single<[RepositoryInfoModel]> {
        return fetchRepositories(query: query, language: language, pagingOffset: pagingOffset).map { items in
            items.map { $0.translate() }
        }
    }
}
