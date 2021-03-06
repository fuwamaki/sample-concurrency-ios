//
//  GithubRepo.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/11.
//

import Foundation

struct GithubRepo: Codable, Identifiable {
    let id: Int
    let fullName: String
    let stargazersCount: Int
    let htmlUrl: String
    let owner: GithubRepoOwner

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case owner
    }
}
