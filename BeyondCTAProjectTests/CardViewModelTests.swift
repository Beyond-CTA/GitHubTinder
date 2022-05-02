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
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 0, "populateRepositoriesメソッドが呼ばれていないか")
        repository.populateRepositoriesHandler = { (keyword, lang) in
            query = keyword
            language = lang
            return MockData.fetchSingleRepositoryInfoModels()
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
        repository.populateRepositoriesHandler = { _, _ in
            return Single.error(MockError.error)
        }
        
        testTarget.input.searchText.onNext(.mock)
        testTarget.input.searchButtonClicked.onNext(())
        
        XCTAssertEqual(repository.populateRepositoriesCallCount, 1, "populateRepositoriesメソッドが一回だけ呼ばれているか")
        XCTAssertEqual(hudShow.value, .error, "エラーHUDが表示されるか")
        XCTAssertNil(hudHide.value, "HUDが非表示になっているか")
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
