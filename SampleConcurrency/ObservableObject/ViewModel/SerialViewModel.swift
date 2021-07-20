//
//  SerialViewModel.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI
import Combine

class SerialViewModel: ObservableObject {
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
extension SerialViewModel {
    func fetch() async throws {
        isLoading = true
        let qiitaTags: [QiitaTag] = try await apiClient.call(url: APIUrl.qiitaTag)
        guard qiitaTags.count > 0 else {
            throw APIError.unknownError
        }
        let firstQiitaTag = qiitaTags[0]
        let firstQiitaTagItem: [QiitaItem] = try await apiClient
            .call(url: APIUrl.qiitaItem(query: firstQiitaTag.id))
        await set(tag: firstQiitaTag, items: firstQiitaTagItem)
    }

    @MainActor func set(tag: QiitaTag, items: [QiitaItem]) {
        list.append(QiitaListEntity(id: tag.id, list: items))
        isLoading = false
    }
}
