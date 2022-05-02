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
    static func fetchSingleRepositoryInfoModels() -> Single<[RepositoryInfoModel]> {
        return Single.just(fetchRepositoryInfoModel())
    }
    
    static func fetchRepositoryInfoModel() -> [RepositoryInfoModel] {
        return items.map { item in
            return item.translate()
        }
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
                defaultBranch: .mock,
                description: .mock
            )
        ]
    }
}

extension String {
    static let mock = "mock"
    static let url = "https://mock.jpg"
}

extension Int {
    static let mock = 1
}
