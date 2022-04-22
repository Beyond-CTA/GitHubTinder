//
//  ErrorModel.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation

enum GitHubAPI {
    // MARK: - ErrorModel
    struct ErrorModel: Codable {
        let message: String
        let errors: [Error]

        enum CodingKeys: String, CodingKey {
            case message, errors
        }
    }

    // MARK: - Error
    struct Error: Codable {
        let message, resource, code: String
    }
}
