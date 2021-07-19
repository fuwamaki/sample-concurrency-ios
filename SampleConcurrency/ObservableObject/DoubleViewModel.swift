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
    func fetchSwift() async throws {
        let list: GithubRepoList = try await apiClient
            .call(url: APIUrl.githubRepo(query: "swift"))
        swiftGithubRepos = list.items
    }

    func fetchKotlin() async throws {
        let list: GithubRepoList = try await apiClient
            .call(url: APIUrl.githubRepo(query: "kotlin"))
        kotlinGithubRepos = list.items
    }
}
