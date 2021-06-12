//
//  APIClient.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation

final class APIClient {

    func fetchGithubRepo(url: URL) async throws -> GithubRepoList {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.unknownError
              }
        do {
            let list = try JSONDecoder().decode(GithubRepoList.self, from: data)
            return list
        } catch {
            throw APIError.jsonParseError
        }
    }

    func fetchImageData(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.unknownError
              }
        return data
    }
}
