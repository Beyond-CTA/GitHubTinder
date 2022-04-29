//
//  Translator.swift
//  BeyondCTAProject
//
//  Created by Tomoya Tanaka on 2022/04/22.
//

import Foundation


extension SearchRepositoriesEntity.Item {
    func traslate() -> RepositoryInfoModel {
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
            readmeBody: readmeBody ?? ""
        )
    }
    
    func traslate(item: SearchRepositoriesEntity.Item) -> RepositoryInfoModel {
        let readmeURL = URL(string: "https://raw.githubusercontent.com/\(fullName)/\(defaultBranch)/README.md")!
        let readmeBody = try? String(contentsOf: readmeURL)
        return RepositoryInfoModel(
            name: item.name,
            fullName: item.fullName,
            avatarURL: item.owner.avatarURL,
            stargazersCount: item.stargazersCount,
            watchersCount: item.watchersCount,
            language: item.language,
            forksCount: item.forksCount,
            openIssuesCount: item.openIssuesCount,
            readmeBody: readmeBody ?? ""
        )
    }
}
