//
//  SearchRepositoriesTests.swift
//  BeyondCTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/04/26.
//

import XCTest
@testable import Moya
@testable import RxSwift
@testable import BeyondCTAProject

class SearchRepositoriesTests: XCTestCase {
    let disposeBag = DisposeBag()
    let targetType = SearchRepositoriesTargetType(query: "RxSwift", language: "swift")

    func test_APIResponseSuccess() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return APIMockHelper.generateEndpointClosure(
                target: target,
                sampleResponse: .response(
                    APIMockHelper.httpURLResponse(target: target, statusCode: 200),
                    SearchRepositoriesEntity.exampleJSON.data(using: .utf8)!
                )
            )
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let response):
                        XCTAssertNotEqual(response.items.count, 0)
                    default:
                        XCTFail("failed: \(result)")
                    }
                }
            )
            .disposed(by: disposeBag)
    }

    func test_APIResponseIsNot2XX() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return APIMockHelper.generateEndpointClosure(
                target: target,
                sampleResponse: .response(
                    APIMockHelper.httpURLResponse(target: target, statusCode: 3000),
                    GitHubAPI.ErrorModel.exampleJSON.data(using: .utf8)!
                )
            )
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)

        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(
                onSuccess: { result in
                    switch result {
                    case .statusCodeIsNot2XX(let response):
                        XCTAssertEqual(response.message, "Validation Failed")
                    default:
                        XCTFail("Unexpected result")
                    }
                },
                onFailure: { error in
                    XCTFail("API Request Failed")
                }).disposed(by: disposeBag)
    }

    func test_APIResponseMoyaError() {
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            return APIMockHelper.generateEndpointClosure(
                target: target,
                sampleResponse: .networkError(NSError(domain: "networkError", code: 300, userInfo: nil)))
        }
        let stubbingProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)

        APIClient.shared
            .send(provider: stubbingProvider, targetType).subscribe(
                onSuccess: { result in
                    switch result {
                    case .moyaError(let moyaError):
                        XCTAssertEqual(moyaError.localizedDescription, "The operation couldn’t be completed. (networkError error 300.)")
                    default:
                        XCTFail("Unexpected error occured")
                    }
                },
                onFailure: { error in
                    XCTFail("API request failed")
                }).disposed(by: disposeBag)
    }
}
