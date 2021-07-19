//
//  QiitaView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct QiitaView: View {
    private var apiClient = APIClient()
    @State var searchText: String = ""
    @State var items: [QiitaItem] = []
    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                List(items) { item in
                    QiitaTempItemView(item: item)
                }
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .tint(.cyan)
                }
            }
            .navigationTitle(Text("Github Repository"))
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, {
            fetch()
        })
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text("エラー"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")))
        }
    }

    private func fetch() {
        guard searchText.count > 0 else { return }
        async {
            isLoading = true
            do {
                items = try await apiClient
                    .fetchQiitaItem(url: APIUrl.qiitaItem(query: searchText))
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

struct QiitaView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaView()
    }
}
