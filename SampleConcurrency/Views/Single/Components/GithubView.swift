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

    var body: some View {
        ZStack {
            List(viewModel.githubRepos) { item in
                GithubTempItemView(repo: item)
            }
            .listStyle(.plain)
            if viewModel.isLoading {
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
        .onDisappear {
            viewModel.isLoading = false
        }
    }

    func fetch(_ text: String) {
        Task {
            do {
                try await viewModel.fetchGithubRepo(text: text)
            } catch let error {
                alertSubject.show(error: error)
            }
        }
    }
}

struct GithubView_Previews: PreviewProvider {
    static var previews: some View {
        GithubView(viewModel: SingleViewModel())
    }
}
