//
//  DoubleView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/16.
//

import SwiftUI

struct GithubDouble: Identifiable {
    var id: String
    let list: [GithubRepo]
}

struct DoubleView: View {
    @ObservedObject private var viewModel = DoubleViewModel()

    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    ForEach(viewModel.repoItems) { item in
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
        async {
            do {
                isLoading = true
                try await viewModel.fetch()
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

struct DoubleView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleView()
    }
}
