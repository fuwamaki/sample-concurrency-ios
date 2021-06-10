//
//  GithubView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct GithubView: View {
    private var apiClient = APIClient()
    @State var items: [GithubRepo] = []

    var body: some View {
        List(items) {
            Label($0.fullName, image: $0.owner.avatarUrl)
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        async {
            items = try await apiClient
                .fetch(
                    url: URL(string: "https://api.github.com/search/repositories?q=swift")!).items
        }
    }
}

struct GithubView_Previews: PreviewProvider {
    static var previews: some View {
        GithubView()
    }
}
