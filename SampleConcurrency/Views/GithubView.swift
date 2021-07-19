//
//  GithubView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct GithubView: View {
    @Binding var selectedType: SingleItemType
    @Binding var searchText: String
    @Binding var isSearching: Bool

    private let apiClient = APIClient()
    @State var items: [GithubRepo] = []
    @State private var isLoading: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var searchedText: String = ""

    var body: some View {
        ZStack {
            List(items) { item in
                GithubTempItemView(repo: item)
            }
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
                    .tint(.cyan)
            }
        }
        .onChange(of: isSearching, perform: { newValue in
            if newValue, selectedType == .github {
                fetch()
            }
        })
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

    func fetch() {
        guard searchText.count > 0, searchedText != searchText else { return }
        async {
            isLoading = true
            do {
                items = try await apiClient
                    .fetchGithubRepo(
                        url: APIUrl.githubRepo(query: searchText))
                    .items
                searchedText = searchText
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
        GithubView(
            selectedType: .constant(.github),
            searchText: .constant(""),
            isSearching: .constant(false))
    }
}
