//
//  QiitaListEntity.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/20.
//

import Foundation

struct QiitaListEntity: Identifiable {
    var id: String
    let list: [QiitaItem]
}
