//
//  APIResult.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation
import Moya

enum APIResult<T: Decodable, E: Decodable> {
    case success(T)
    // NOTE: APIからエラーのレスポンスが帰ってきた時(200...299)以外
    case statusCodeIsNot2XX(E)
    case moyaError(MoyaError)
    case unexpectedError(UnexpectedError)
}

