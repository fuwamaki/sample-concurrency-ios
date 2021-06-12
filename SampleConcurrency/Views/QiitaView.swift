//
//  QiitaView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct QiitaView: View {
    private var apiClient = APIClient()
    var body: some View {
        Button {
            fetch()
        } label: {
            Text("fetch")
        }
    }

    private func fetch() {
        async {
            let aaa = try await apiClient.fetchGithubRepo(
                url: URL(string: "https://api.github.com/search/repositories?q=swift")!)
            print(aaa)
        }
    }
}

struct QiitaView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaView()
    }
}
