//
//  Translator.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/22.
//

import Foundation


extension SearchRepositoriesEntity.Item {
    func traslate() -> RepositoryInfoModel {
        let readmeURL = URL(string: "https://raw.githubusercontent.com/\(fullName)/\(masterBranch)/README.md")!
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
            readmeBody: readmeBody ?? ""
        )
    }
}
