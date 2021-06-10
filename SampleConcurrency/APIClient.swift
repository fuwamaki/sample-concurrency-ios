//
//  APIClient.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation

final class APIClient {

    func fetch(url: URL) async throws -> GithubRepoList {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.unknownError
        }
        do {
            let list = try JSONDecoder().decode(GithubRepoList.self, from: data)
            return list
        } catch {
            throw APIError.jsonParseError
        }
    }
}

enum APIError: Error {
    case customError(message: String)
    case nonDataError
    case unauthorizedError
    case notFoundError
    case maintenanceError
    case networkError
    case jsonParseError
    case unknownError

    var message: String {
        switch self {
        case .customError(let message):
            return message
        case .nonDataError:
            return "nonDataError"
        case .unauthorizedError:
            return "unauthorizedError"
        case .notFoundError:
            return "notFoundError"
        case .maintenanceError:
            return "maintenanceError"
        case .networkError:
            return "networkError"
        default:
            return "unknownError"
        }
    }
}

struct GithubRepoList: Codable {
    let items: [GithubRepo]
}

struct GithubRepo: Codable, Identifiable {
    let id: Int
    let fullName: String
    let stargazersCount: Int
    let htmlUrl: String
    let owner: GithubRepoOwner

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case owner
    }

    init(id: Int,
         fullName: String,
         stargazersCount: Int,
         htmlUrl: String,
         owner: GithubRepoOwner) {
        self.id = id
        self.fullName = fullName
        self.stargazersCount = stargazersCount
        self.htmlUrl = htmlUrl
        self.owner = owner
    }
}

struct GithubRepoOwner: Codable {
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }

    init(avatarUrl: String) {
        self.avatarUrl = avatarUrl
    }
}
