//
//  APIUrl.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/11.
//

import Foundation

struct APIUrl {
    static func githubRepo(query: String) -> URL {
        return URL(string: "https://api.github.com/search/repositories?q=\(query)")!
    }

    static func qiitaItem(query: String, page: Int = 1, perPage: Int = 20) -> URL {
        return URL(string: "https://qiita.com/api/v2/items?page=\(String(page))&per_page=\(String(perPage))&q=\(query)")!
    }
}
