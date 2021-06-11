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

    @Environment(\.isSearching)
    private var isSearching: Bool

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    GithubItemView(repo: item)
                }
            }
            .navigationTitle(Text("Github Repository"))
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, {
            async {
                await fetch()
            }
        })
    }

    private func fetch() async {
        guard searchText.count > 0 else { return }
        async {
            items = try await apiClient
                .fetch(url: APIUrl.githubRepo(query: searchText))
                .items
        }
    }
}

struct GithubView_Previews: PreviewProvider {
    static var previews: some View {
        GithubView()
    }
}
