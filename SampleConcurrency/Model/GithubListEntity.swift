//
//  GithubListEntity.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/20.
//

import Foundation

struct GithubListEntity: Identifiable {
    var id: String
    let list: [GithubRepo]
}
