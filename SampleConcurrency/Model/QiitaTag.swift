//
//  QiitaTag.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/16.
//

import Foundation

struct QiitaTag: Codable {
    let followersCount: Int
    let iconUrl: String
    let id: String
    let itemsCount: Int

    enum CodingKeys: String, CodingKey {
        case followersCount = "followers_count"
        case iconUrl = "icon_url"
        case id
        case itemsCount = "items_count"
    }
}
