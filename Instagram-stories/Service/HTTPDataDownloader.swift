//
//  HTTPDataDownloader.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import Foundation

class HTTPDataDownloader {
    
    func getUsers(withOffset: Int = 0, limit: Int = 30) async throws -> [User] {
        let baseUrl = "https://api.slingacademy.com/v1/sample-data/users?limit=\(limit)&offset=\(withOffset)"

        guard let url = URL(string: baseUrl) else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        let result = try JSONDecoder().decode(UserResponse.self, from: data)

        return result.users
    }
    
    func getPhotos(withOffset: Int = 0, limit: Int = 30) async throws -> [Photo] {
        let baseUrl = "https://api.slingacademy.com/v1/sample-data/photos?limit=\(limit)&offset=\(withOffset)"

        guard let url = URL(string: baseUrl) else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        let result = try JSONDecoder().decode(PhotoResponse.self, from: data)
        
        print(result)
        return result.photos
    }
    
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
}
