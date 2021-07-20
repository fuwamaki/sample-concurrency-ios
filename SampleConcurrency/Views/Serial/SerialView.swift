//
//  SerialView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import SwiftUI

struct SerialView: View {
    @ObservedObject private var viewModel = SerialViewModel()
    @ObservedObject var alertSubject: AlertSubject = AlertSubject()

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    ForEach(viewModel.list) { item in
                        Text(item.id)
                            .font(.title3)
                            .padding(.top, 2)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(item.list) { value in
                                    QiitaSquareItemView(item: value)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .tint(.cyan)
                }
            }
            .navigationTitle(Text("Github Repositories"))
            .background(Color(UIColor.systemGray6))
        }
        .alert(isPresented: $alertSubject.isShow) {
            alertSubject.alert
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        async {
            do {
                try await viewModel.fetch()
            } catch let error {
                alertSubject.show(error: error)
            }
        }
    }
}

struct SerialView_Previews: PreviewProvider {
    static var previews: some View {
        SerialView()
    }
}
