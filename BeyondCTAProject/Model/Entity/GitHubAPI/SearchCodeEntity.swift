//
//  SearchCodeEntity.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/21.
//

import Foundation

// MARK: - SearchCodeEntity
struct SearchCodeEntity: Codable {
    let totalCount: Int
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let name: String
    let gitURL: String
    let htmlURL: String
    let repository: Repository

    enum CodingKeys: String, CodingKey {
        case name
        case gitURL = "git_url"
        case htmlURL = "html_url"
        case repository
    }
}

// MARK: - Repository
struct Repository: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let avatarURL, htmlURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
