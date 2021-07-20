//
//  DoubleViewModel.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI

class DoubleViewModel: ObservableObject {
    @Published var swiftGithubRepos: [GithubRepo] = []
    @Published var kotlinGithubRepos: [GithubRepo] = []

    var repoItems: [GithubDouble] {
        var items: [GithubDouble] = []
        if swiftGithubRepos.count > 0 {
            items.append(GithubDouble(id: "swift", list: swiftGithubRepos))
        }
        if kotlinGithubRepos.count > 0 {
            items.append(GithubDouble(id: "kotlin", list: kotlinGithubRepos))
        }
        return items
    }

    private var apiClient = APIClient()
}

// API
extension DoubleViewModel {
    func fetch() async throws {
        async let swiftList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "swift"))
        async let kotlinList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "kotlin"))
        let list = try await [swiftList, kotlinList]
        await aaa(list: list)
    }

    @MainActor func aaa(list: [GithubRepoList]) {
        swiftGithubRepos = list[0].items
        kotlinGithubRepos = list[1].items
    }
}
