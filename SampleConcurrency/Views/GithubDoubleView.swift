//
//  GithubDoubleView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/16.
//

import SwiftUI

struct GithubDouble: Identifiable {
    var id: String
    let list: [GithubRepo]
}

struct GithubDoubleView: View {
    private var apiClient = APIClient()
    @State var items: [GithubDouble] = []
    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    ForEach(items) { item in
                        Text(item.id)
                            .font(.title3)
                            .padding(.top, 2)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(item.list) { repo in
                                    GithubSquareItemView(repo: repo)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .tint(.cyan)
                }
            }
            .navigationTitle(Text("Github Repositories"))
            .background(Color(UIColor.systemGray6))
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
        guard items.isEmpty else { return }
        async {
            isLoading = true
            do {
                let firstItems = try await apiClient
                    .fetchGithubRepo(
                        url: APIUrl.githubRepo(query: "swift"))
                    .items
                items.append(GithubDouble(id: "swift", list: firstItems))
                let secondItems = try await apiClient
                    .fetchGithubRepo(
                        url: APIUrl.githubRepo(query: "kotlin"))
                    .items
                items.append(GithubDouble(id: "kotlin", list: secondItems))
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
