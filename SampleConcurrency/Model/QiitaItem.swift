//
//  QiitaItem.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/16.
//

import Foundation

struct QiitaItem: Codable, Identifiable {
    let id: String
    let title: String
    let url: String
    let commentsCount: Int
    let likesCount: Int
    let reactionsCount: Int
    let tags: [QiitaItemTag]
    let user: QiitaItemUser
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case commentsCount = "comments_count"
        case likesCount = "likes_count"
        case reactionsCount = "reactions_count"
        case tags
        case user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
