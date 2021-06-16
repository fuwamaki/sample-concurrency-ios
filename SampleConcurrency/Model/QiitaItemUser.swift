//
//  QiitaItemUser.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/16.
//

import Foundation

struct QiitaItemUser: Codable {
    let id: String
    let name: String
    let description: String
    let profileImageUrl: String
    let followeesCount: Int
    let followersCount: Int
    let itemsCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case profileImageUrl = "profile_image_url"
        case followeesCount = "followees_count"
        case followersCount = "followers_count"
        case itemsCount = "items_count"
    }
}
