//
//  SingleViewModel.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI
import Combine

class SingleViewModel: ObservableObject {
    @Published var githubRepos: [GithubRepo] = []
    @Published var qiitaItems: [QiitaItem] = []
    @Published var searchText: String = ""

    private var apiClient = APIClient()
    private var githubQuery: String = ""
    private var qiitaQuery: String = ""
}

// API
extension SingleViewModel {
    func fetchGithubRepo(text: String) async throws {
        guard text.count > 0, githubQuery != text else { return }
        githubRepos = try await apiClient
            .fetchGithubRepo(url: APIUrl.githubRepo(query: text))
            .items
        githubQuery = text
    }

    func fetchQiitaItem(text: String) async throws {
        guard text.count > 0, qiitaQuery != text else { return }
        qiitaItems = try await apiClient
            .fetchQiitaItem(url: APIUrl.qiitaItem(query: text))
        qiitaQuery = text
    }
}
