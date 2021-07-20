//
//  GithubView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct GithubView: View {
    @ObservedObject var viewModel: SingleViewModel
    @StateObject var alertSubject: AlertSubject = AlertSubject()
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            List(viewModel.githubRepos) { item in
                GithubTempItemView(repo: item)
            }
            .listStyle(.plain)
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
                    .tint(.cyan)
            }
        }
        .alert(isPresented: $alertSubject.isShow) {
            alertSubject.alert
        }
        .onReceive(viewModel.$searchText) { text in
            fetch(text)
        }
    }

    func fetch(_ text: String) {
        async {
            isLoading = true
            do {
                try await viewModel.fetchGithubRepo(text: text)
            } catch let error {
                if let apiError = error as? APIError {
                    self.alertSubject.show(message: apiError.message)
                }
            }
            isLoading = false
        }
    }
}

struct GithubView_Previews: PreviewProvider {
    static var previews: some View {
        GithubView(viewModel: SingleViewModel())
    }
}
