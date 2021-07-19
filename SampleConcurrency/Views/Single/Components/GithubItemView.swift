//
//  GithubItemView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/12.
//

import SwiftUI

// memo: AsyncImageが正常に機能しないので、現状未使用。
struct GithubItemView: View {
    var repo: GithubRepo

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: repo.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
                    .tint(.cyan)
            }
            .frame(width: 40, height: 40)
            .mask(RoundedRectangle(cornerRadius: 20))
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
    }
}

struct GithubItemView_Previews: PreviewProvider {
    static var previews: some View {
        GithubItemView(
            repo: GithubRepo(
                id: 0,
                fullName: "name",
                stargazersCount: 10,
                htmlUrl: "",
                owner: GithubRepoOwner(avatarUrl: "")))
    }
}
