//
//  QiitaSquareItemView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/20.
//

import SwiftUI

struct QiitaSquareItemView: View {
    private let apiClient = APIClient()
    var item: QiitaItem
    @State var imageData: Data?

    var body: some View {
        HStack {
            if let imageData = imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .mask(RoundedRectangle(cornerRadius: 20))
            } else {
                ProgressView()
                    .tint(.cyan)
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)
                Label(String(item.likesCount),
                      systemImage: "star")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .symbolRenderingMode(.multicolor)
            }
            Spacer()
        }
        .padding()
        .frame(width: 200, height: 100)
        .background(.white)
        .cornerRadius(13)
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        Task {
            guard imageData == nil else { return }
            imageData = try await apiClient
                .fetchImageData(
                    url: URL(string: item.user.profileImageUrl)!)
        }
    }
}

struct QiitaSquareItemView_Previews: PreviewProvider {
    static var previews: some View {
        QiitaSquareItemView(
            item: QiitaItem(
                id: "test_id",
                title: "test_title",
                url: "https://www.google.com",
                commentsCount: 0,
                likesCount: 0,
                reactionsCount: 0,
                tags: [],
                user: QiitaItemUser(
                    id: "test_user_id",
                    name: "test_name",
                    description: nil,
                    profileImageUrl: "https://www.google.com",
                    followeesCount: 0,
                    followersCount: 0,
                    itemsCount: 0),
                createdAt: "",
                updatedAt: ""))
    }
}
