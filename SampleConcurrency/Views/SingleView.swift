//
//  SingleView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI

enum SingleItemType: Int {
    case github = 0
    case qiita = 1

    var title: String {
        switch self {
        case .github:
            return "Github Repository"
        case .qiita:
            return "Qiita Item"
        }
    }

    var text: String {
        switch self {
        case .github:
            return "Github"
        case .qiita:
            return "Qiita"
        }
    }
}

struct SingleView: View {
    @State private var selectedType: SingleItemType = .github
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Picker("Item Type", selection: self.$selectedType) {
                    Text(SingleItemType.github.text)
                        .tag(SingleItemType.github)
                    Text(SingleItemType.qiita.text)
                        .tag(SingleItemType.qiita)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 16.0)
                switch selectedType {
                case .github:
                    GithubView(
                        selectedType: $selectedType,
                        searchText: $searchText,
                        isSearching: $isSearching)
                case .qiita:
                    QiitaView(
                        selectedType: $selectedType,
                        searchText: $searchText,
                        isSearching: $isSearching)
                }
            }
            .navigationTitle(Text(selectedType.title))
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, {
            guard searchText.count > 0 else { return }
            isSearching = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isSearching = false
            }
        })
    }
}

struct SingleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleView()
    }
}
