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
}
