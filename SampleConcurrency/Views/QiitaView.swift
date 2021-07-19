//
//  QiitaView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI

struct QiitaView: View {
    @Binding var selectedType: SingleItemType
    @Binding var searchText: String
    @Binding var isSearching: Bool

    private let apiClient = APIClient()
    @State private var items: [QiitaItem] = []
    @State private var isLoading: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var searchedText: String = ""

    var body: some View {
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
        .onChange(of: isSearching, perform: { newValue in
            if newValue, selectedType == .qiita {
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
                    .fetchQiitaItem(url: APIUrl.qiitaItem(query: searchText))
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

struct QiitaView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaView(
            selectedType: .constant(.qiita),
            searchText: .constant(""),
            isSearching: .constant(false))
    }
}
