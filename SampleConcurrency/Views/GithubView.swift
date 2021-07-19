//
//  GithubView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct GithubView: View {
    @ObservedObject var viewModel: SingleViewModel

    @State private var isLoading: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        ZStack {
            List(viewModel.githubRepos) { item in
                GithubTempItemView(repo: item)
            }
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
                    .tint(.cyan)
            }
        }
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text("エラー"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")))
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
                    alertMessage = apiError.message
                    isShowAlert.toggle()
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
