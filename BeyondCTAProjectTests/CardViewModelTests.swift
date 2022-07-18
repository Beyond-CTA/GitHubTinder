//
//  CardViewModelTests.swift
//  BeyondCTAProjectTests
//
//  Created by Taisei Sakamoto on 2022/04/30.
//

@testable import BeyondCTAProject
import RxSwift
import XCTest

final class CardViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var dependency: Dependency!
    
    // MARK: - Tests
    
    func test_searchButtonClicked_success() {
        dependency = Dependency()
        let testTarget = dependency.testTarget
        let repository = dependency.searchRepositoryMock
        let hudShow = WatchStream(testTarget.output.hudShow)
        let hudHide = WatchStream(testTarget.output.hudHide)
        let repositoryInfoModels = WatchStream(testTarget.output.repositoryInfoModels)
        var query: String?
        var language: String? // 絞り込み検索の仕様次第
        var pagingOffset: Int?
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 0, "populateRepositoriesメソッドが呼ばれていないか")
        repository.populateRepositoriesHandler = { (keyword, lang, offset) in
            query = keyword
            language = lang
            pagingOffset = offset
            return MockData.singleFetchRepositoryInfoModels()
        }
        
        testTarget.input.searchText.onNext(.mock)
        testTarget.input.searchButtonClicked.onNext(())
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 1, "populateRepositoriesメソッドが一回だけ呼ばれているか")
        XCTAssertEqual(hudShow.value, .progress, "progressタイプのHUDが表示されているか")
        XCTAssertEqual(query, .mock, "検索クエリを流せているか")
        XCTAssertEqual(repositoryInfoModels.value, MockData.fetchRepositoryInfoModel(), "MockのRepositoriesが返ってくるか")
        XCTAssertNotNil(hudHide.value, "HUDが非表示になっているか")
    }
    
    func test_searchButtonClicked_failure() {
        dependency = Dependency()
        let testTarget = dependency.testTarget
        let repository = dependency.searchRepositoryMock
        let hudShow = WatchStream(testTarget.output.hudShow)
        let hudHide = WatchStream(testTarget.output.hudHide)
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 0, "populateRepositoriesメソッドが呼ばれていないか")
        repository.populateRepositoriesHandler = { _, _, _ in
            return Single.error(MockError.error)
        }
        
        testTarget.input.searchText.onNext(.mock)
        testTarget.input.searchButtonClicked.onNext(())
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 1, "populateRepositoriesメソッドが一回だけ呼ばれているか")
        XCTAssertEqual(hudShow.value, .error, "エラーHUDが表示されるか")
        XCTAssertNotNil(hudHide.value, "HUDが非表示になっているか")
    }
    
    func test_noResults() {
        dependency = Dependency()
        let testTarget = dependency.testTarget
        let repository = dependency.searchRepositoryMock
        let hudShow = WatchStream(testTarget.output.hudShow)
        let hudHide = WatchStream(testTarget.output.hudHide)
        let noResultsAlert = WatchStream(testTarget.output.noResults)
        let repositoryInfoModels = WatchStream(testTarget.output.repositoryInfoModels)

        var query: String?
        var language: String?
        var pagingOffset: Int?
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 0, "populateRepositoriesメソッドが呼ばれていないか")
        repository.populateRepositoriesHandler = { (keyword, lang, offset) in
            query = keyword
            language = lang
            pagingOffset = offset
            return MockData.singleFetchNoHitRepositoryInfoModel()
        }
        
        testTarget.input.searchText.onNext(.mock)
        testTarget.input.searchButtonClicked.onNext(())
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 1, "populateRepositoriesメソッドが一回だけ呼ばれているか")
        XCTAssertEqual(hudShow.value, .progress, "progressタイプのHUDが表示されているか")
        XCTAssertEqual(query, .mock, "検索クエリが流せているか")
        XCTAssertEqual(repositoryInfoModels.value, MockData.noHitRepositoryInfoModel(), "MockのRepositoriesが返ってくるか")
        XCTAssertNotNil(hudHide.value, "HUDが非表示になっているか")
        XCTAssertNotNil(noResultsAlert.value, "検索がヒットしなかった場合のアラートが表示されるか")
    }
}

// MARK: - Extensions

extension CardViewModelTests {
    struct Dependency {
        let testTarget: CardViewModel
        let searchRepositoryMock:  SearchRepositoryTypeMock
        
        init() {
            self.searchRepositoryMock = SearchRepositoryTypeMock()
            testTarget = CardViewModel(searchRepository: searchRepositoryMock)
        }
    }
}
