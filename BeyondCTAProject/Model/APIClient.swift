//
//  APIClient.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/19.
//

import Foundation
import Moya
import RxSwift

/// @mockable
protocol APIClientProtocol {
    func send<Request: BaseTargetType>(provider: MoyaProvider<MultiTarget>, _ request: Request) -> Single<APIResult<Request.Response, Request.ErrorResponse>>
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private init() {}

    func send<Request: BaseTargetType>(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>(), _ request: Request) -> Single<APIResult<Request.Response, Request.ErrorResponse>> {
        return provider.rx.request(MultiTarget(request))
            .map { result in
                guard (200...299).contains(result.statusCode) else {
                    let apiError = try result.map(Request.ErrorResponse.self)
                    return .statusCodeIsNot2XX(apiError)
                }
                let response = try result.map(Request.Response.self, using: APIClient.decoder)
                return .success(response)
            }
            .catch { (error) -> Single<APIResult<Request.Response, Request.ErrorResponse>> in
                guard let moyaError = error as? MoyaError else {
                    return .just(.unexpectedError(UnexpectedError()))
                }
                return .just(.moyaError(moyaError))
            }
    }
}

// MARK: Decoder
extension APIClient {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
