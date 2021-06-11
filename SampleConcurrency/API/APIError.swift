//
//  APIError.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/11.
//

import Foundation

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
