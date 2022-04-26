//
//  APIMockHelper.swift
//  BeyondCTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/04/26.
//

import Foundation
@testable import Moya

enum APIMockHelper {
    static func generateEndpointClosure(target: MultiTarget, sampleResponse: EndpointSampleResponse) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: {
                sampleResponse
            },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    static func httpURLResponse(target: MultiTarget, statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: URL(target: target),
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
