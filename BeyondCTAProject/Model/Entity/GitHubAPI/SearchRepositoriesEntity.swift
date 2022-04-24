//
//  SearchRepositoriesEntity.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation

// MARK: - SearchRepositories
struct SearchRepositoriesEntity: Codable {
    let items: [Item]
    // MARK: - Item
    struct Item: Codable {
        let name, fullName: String
        let owner: Owner
        let stargazersCount, watchersCount: Int
        let language: String
        let forksCount, openIssuesCount: Int
        let masterBranch: String

        enum CodingKeys: String, CodingKey {
            case name
            case fullName = "full_name"
            case owner
            case stargazersCount = "stargazers_count"
            case watchersCount = "watchers_count"
            case language
            case forksCount = "forks_count"
            case openIssuesCount = "open_issues_count"
            case masterBranch = "master_branch"
        }
    }

    // MARK: - Owner
    struct Owner: Codable {
        let avatarURL: String

        enum CodingKeys: String, CodingKey {
            case avatarURL = "avatar_url"
        }
    }
}

