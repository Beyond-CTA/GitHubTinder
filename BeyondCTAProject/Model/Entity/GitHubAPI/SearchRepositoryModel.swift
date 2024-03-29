//
//  SearchRepositoryModel.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/22.
//

import Foundation

struct RepositoryInfoModel: Equatable {
    let name: String
    let fullName: String
    let description: String
    let avatarURL: String
    let stargazersCount: Int
    let watchersCount: Int
    let language: String
    let forksCount: Int
    let openIssuesCount: Int
    let readmeBody: String
    let url: String
}
