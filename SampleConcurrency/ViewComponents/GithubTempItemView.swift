//
//  GithubTempItemView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/12.
//

import SwiftUI

struct GithubTempItemView: View {
    private let apiClient = APIClient()
    var repo: GithubRepo
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
                Text(repo.fullName)
                    .font(.body)
                Label(String(repo.stargazersCount),
                      systemImage: "star")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .symbolRenderingMode(.multicolor)
            }
        }
        .onAppear {
            fetch()
        }
    }

    private func fetch() {
        async {
            guard imageData == nil else { return }
            imageData = try await apiClient
                .fetchImageData(url: URL(string: repo.owner.avatarUrl)!)
        }
    }
}

struct GithubTempItemView_Previews: PreviewProvider {
    static var previews: some View {
        GithubTempItemView(
            repo: GithubRepo(
                id: 0,
                fullName: "name",
                stargazersCount: 10,
                htmlUrl: "",
                owner: GithubRepoOwner(avatarUrl: "")))
    }
}