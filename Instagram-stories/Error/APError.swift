//
//  APError.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToLoadData
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid data retrun from API"
        case .invalidURL:
            return "Invalid URL provided"
        case .invalidResponse:
            return "Invalid Response from API"
        case .unableToLoadData:
            return "Unable to load data"
        }
    }
}
