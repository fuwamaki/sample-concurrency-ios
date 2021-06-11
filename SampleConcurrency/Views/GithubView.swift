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
            List(items) {
                Label($0.fullName, image: $0.owner.avatarUrl)
            }
            .navigationTitle(Text("Github Repository"))
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, {
            fetch()
        })
    }

    private func fetch() {
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
