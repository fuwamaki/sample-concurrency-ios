//
//  APIClient.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation

final class APIClient {

    func fetchQiitaTag(url: URL) async throws -> [QiitaTag] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.unknownError
              }
        do {
            let list = try JSONDecoder().decode([QiitaTag].self, from: data)
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

    func call<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw APIError.unknownError
              }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.jsonParseError
        }
    }
}
