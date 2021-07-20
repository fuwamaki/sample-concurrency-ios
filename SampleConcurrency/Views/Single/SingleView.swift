//
//  SingleView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI

struct SingleView: View {
    @ObservedObject private var viewModel = SingleViewModel()
    @State private var selectedType: SingleItemType = .github
    @State private var searchText: String = ""

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
                    GithubView(viewModel: viewModel)
                case .qiita:
                    QiitaView(viewModel: viewModel)
                }
            }
            .navigationTitle(Text(selectedType.title))
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, {
            viewModel.searchText = searchText
        })
    }
}

struct SingleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleView()
    }
}
