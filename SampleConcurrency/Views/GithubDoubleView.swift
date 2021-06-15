//
//  GithubDoubleView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/16.
//

import SwiftUI

struct GithubDoubleView: View {
    private var apiClient = APIClient()
    @State var firstItems: [GithubRepo] = []
    @State var secondItems: [GithubRepo] = []
    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(firstItems) { item in
                                GithubSquareItemView(repo: item)
                            }
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(secondItems) { item in
                                GithubSquareItemView(repo: item)
                            }
                        }
                    }
                    Spacer()
                }
                .background(Color(UIColor.systemGray6))
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .tint(.cyan)
                }
            }
            .navigationTitle(Text("Github Repositories"))
        }
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text("エラー"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")))
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        async {
            isLoading = true
            do {
                firstItems = try await apiClient
                    .fetchGithubRepo(
                        url: APIUrl.githubRepo(query: "swift"))
                    .items
                secondItems = try await apiClient
                    .fetchGithubRepo(
                        url: APIUrl.githubRepo(query: "kotlin"))
                    .items
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

struct GithubDoubleView_Previews: PreviewProvider {
    static var previews: some View {
        GithubDoubleView()
    }
}
