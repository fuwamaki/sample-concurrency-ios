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
}

// API
extension SingleViewModel {
    func fetchGithubRepo(text: String) async throws {
        guard text.count > 0 else { return }
        githubRepos = try await apiClient
            .fetchGithubRepo(url: APIUrl.githubRepo(query: text))
            .items
    }

    func fetchQiitaItem(text: String) async throws {
        guard text.count > 0 else { return }
        qiitaItems = try await apiClient
            .fetchQiitaItem(url: APIUrl.qiitaItem(query: text))
    }
}
