//
//  SearchRepositoriesTargetType.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation
import Moya

struct SearchRepositoriesTargetType: BaseTargetType {
    typealias Response = SearchRepositoriesEntity
    typealias ErrorResponse = GitHubAPI.ErrorModel

    let query: String
    let language: String

    var baseURL: URL {
       return URL(string: "https://api.github.com")!
    }

    var path: String {
        return "/search/repositories"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestParameters(
            parameters: queryParameters,
            encoding: URLEncoding.default
        )
    }

    var headers: [String : String]? {
        return nil
    }

    var queryParameters: [String : String] {
        return [
            "q": "\(query)+language:\(language)"
        ]
    }
}

