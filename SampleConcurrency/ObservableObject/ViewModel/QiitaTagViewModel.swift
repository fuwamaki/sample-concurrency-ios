//
//  QiitaTagViewModel.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI
import Combine

class QiitaTagViewModel: ObservableObject {
    @Published var githubRepos: [GithubRepo] = []
    @Published var qiitaItems: [QiitaItem] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var list: [QiitaListEntity] = []

    private var apiClient = APIClient()
    private var githubQuery: String = ""
    private var qiitaQuery: String = ""
}

// API
extension QiitaTagViewModel {
    func fetch() async throws {
        isLoading = true
        let list: [QiitaTag] = try await apiClient.call(url: APIUrl.qiitaTag)
        print(list)
        isLoading = false
    }
}
