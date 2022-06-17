//
//  MockData.swift
//  BeyondCTAProjectTests
//
//  Created by Taisei Sakamoto on 2022/04/30.
//

@testable import BeyondCTAProject
import Foundation
import RxSwift

enum MockData {
    static func singleFetchRepositoryInfoModels() -> Single<[RepositoryInfoModel]> {
        return Single.just(fetchRepositoryInfoModel())
    }
    
    static func fetchRepositoryInfoModel() -> [RepositoryInfoModel] {
        return items.map { $0.translate() }
    }
    
    static func singleFetchNoHitRepositoryInfoModel() -> Single<[RepositoryInfoModel]> {
        return Single.just(noHitRepositoryInfoModel())
    }
    
    static func noHitRepositoryInfoModel() -> [RepositoryInfoModel] {
        return noItem
    }
}

extension MockData {
    static let owner = SearchRepositoriesEntity.Owner(avatarURL: .url)
    
    static var items: [SearchRepositoriesEntity.Item] {
        return [
            SearchRepositoriesEntity.Item(
                name: .mock,
                fullName: .mock,
                owner: owner,
                stargazersCount: .mock,
                watchersCount: .mock,
                language: .mock,
                forksCount: .mock,
                openIssuesCount: .mock,
                description: .mock,
                defaultBranch: .mock
            )
        ]
    }
    
    static var noItem: [RepositoryInfoModel] {
        return []
    }
}

extension String {
    static let mock = "mock"
    static let url = "https://mock.jpg"
}

extension Int {
    static let mock = 1
}
