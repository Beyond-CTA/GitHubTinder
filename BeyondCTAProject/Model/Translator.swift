//
//  Translator.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/22.
//

import Foundation


extension SearchRepositoriesEntity.Item {
    func translate() -> RepositoryInfoModel {
        let readmeURL = URL(string: "https://raw.githubusercontent.com/\(fullName)/\(defaultBranch)/README.md")!
        let readmeBody = try? String(contentsOf: readmeURL)
        return RepositoryInfoModel(
            name: name,
            fullName: fullName,
            avatarURL: owner.avatarURL,
            stargazersCount: stargazersCount,
            watchersCount: watchersCount,
            language: language,
            forksCount: forksCount,
            openIssuesCount: openIssuesCount,
            readmeBody: readmeBody ?? "",
            description: description
        )
    }
}
