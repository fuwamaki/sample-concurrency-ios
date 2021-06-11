//
//  GithubItemView.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/12.
//

import SwiftUI

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
            }
            .frame(width: 40, height: 40)
            .mask(RoundedRectangle(cornerRadius: 20))
            Text(repo.fullName)
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
