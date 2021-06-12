//
//  GithubView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct GithubView: View {
    private var apiClient = APIClient()
    @State var searchText: String = ""
    @State var items: [GithubRepo] = []
    @State var isLoading: Bool = false

    @Environment(\.isSearching)
    private var isSearching: Bool

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(items) { item in
                        GithubItemView(repo: item)
                    }
                }
                if isLoading {
                    ProgressView()
                        .frame(width: 20, height: 20)
                        .tint(.cyan)
                }
            }
            .navigationTitle(Text("Github Repository"))
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, {
            fetch()
        })
    }

    private func fetch() {
        guard searchText.count > 0 else { return }
        async {
            isLoading = true
            items = try await apiClient
                .fetch(url: APIUrl.githubRepo(query: searchText))
                .items
            isLoading = false
        }
    }
}

struct GithubView_Previews: PreviewProvider {
    static var previews: some View {
        GithubView()
    }
}
