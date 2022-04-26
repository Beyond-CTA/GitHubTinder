//
//  SearchRepositoriesEntityTests.swift
//  BeyondCTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/04/26.
//

import XCTest
@testable import BeyondCTAProject

class SearchRepositoriesEntityTests: XCTestCase {

    func test_translateEntitySuccess() throws {
        let repositoryInfoModel = SearchRepositoriesEntity.exampleInstance.traslate()
        dump(repositoryInfoModel)
        XCTAssertEqual(repositoryInfoModel.fullName, RepositoryInfoModel.exampleInstance.fullName)
        XCTAssertNotEqual(repositoryInfoModel.readmeBody, RepositoryInfoModel.exampleInstance.readmeBody)
    }

    func test_decodingResponseSuccess() throws {
        let decoder = JSONDecoder()
        let result = try! decoder.decode(SearchRepositoriesEntity.self, from: SearchRepositoriesEntity.exampleJSON.data(using: .utf8)!)
        dump(result)
        XCTAssertNotEqual(result.items.count, 0)
    }

}

extension SearchRepositoriesEntity {
    static let exampleInstance: Self.Item =
        SearchRepositoriesEntity.Item(
            name: "RxSwift",
            fullName: "ReactiveX/RxSwift",
            owner: Owner(avatarURL: "https://avatars.githubusercontent.com/u/6407041?v=4"),
            stargazersCount: 22082,
            watchersCount: 22082,
            language: "Swift",
            forksCount: 3937,
            openIssuesCount: 11,
            defaultBranch: "main"
        )

}

extension RepositoryInfoModel {
    static let exampleInstance: Self = RepositoryInfoModel(
        name: "RxSwift",
        fullName: "ReactiveX/RxSwift",
        avatarURL: "https://avatars.githubusercontent.com/u/6407041?v=4",
        stargazersCount: 22082,
        watchersCount: 22082,
        language: "Swift",
        forksCount: 3937,
        openIssuesCount: 11,
        // 分からんから一旦これで
        readmeBody: ""
    )
}
