//
//  ParallelViewModel.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI

class ParallelViewModel: ObservableObject {
    @Published var swiftGithubRepos: [GithubRepo] = []
    @Published var kotlinGithubRepos: [GithubRepo] = []
    @Published var qiitaItems: [QiitaItem] = []
    @Published var isLoading: Bool = false

    var doubleList: [GithubListEntity] {
        var items: [GithubListEntity] = []
        if swiftGithubRepos.count > 0 {
            items.append(GithubListEntity(id: "swift", list: swiftGithubRepos))
        }
        if kotlinGithubRepos.count > 0 {
            items.append(GithubListEntity(id: "kotlin", list: kotlinGithubRepos))
        }
        return items
    }

    private var apiClient = APIClient()
}

// API
extension ParallelViewModel {
    func fetch() async throws {
        isLoading = true
        async let swiftList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "swift"))
        async let kotlinList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "kotlin"))
        let list = try await [swiftList, kotlinList]
        await set(list: list)
    }

    @MainActor func set(list: [GithubRepoList]) {
        swiftGithubRepos = list[0].items
        kotlinGithubRepos = list[1].items
        isLoading = false
    }

    func fetch2() async throws {
        isLoading = true
        async let swiftList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "swift"))
        async let kotlinList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "kotlin"))
        let list = try await (swiftList, kotlinList)
        await set(list: list)
    }

    @MainActor func set(list: (GithubRepoList, GithubRepoList)) {
        swiftGithubRepos = list.0.items
        kotlinGithubRepos = list.1.items
        isLoading = false
    }

    func fetchGithubAndQiita() async throws {
        isLoading = true
        async let swiftList: GithubRepoList = apiClient
            .call(url: APIUrl.githubRepo(query: "swift"))
        async let kotlinList: [QiitaItem] = apiClient
            .call(url: APIUrl.qiitaItem(query: "kotlin"))
        let list = try await (swiftList, kotlinList)
        await set(list: list)
    }

    @MainActor func set(list: (GithubRepoList, [QiitaItem])) {
        swiftGithubRepos = list.0.items
        qiitaItems = list.1
        isLoading = false
    }
}
