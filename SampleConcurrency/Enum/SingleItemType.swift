//
//  SingleItemType.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/07/19.
//

import Foundation

enum SingleItemType: Int {
    case github = 0
    case qiita = 1

    var title: String {
        switch self {
        case .github:
            return "Github Repository"
        case .qiita:
            return "Qiita Item"
        }
    }

    var text: String {
        switch self {
        case .github:
            return "Github"
        case .qiita:
            return "Qiita"
        }
    }
}
