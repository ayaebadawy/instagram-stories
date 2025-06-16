//
//  Photo.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

struct PhotoResponse: Codable, Equatable {
    let success: Bool
    let totalPhotos: Int
    let message: String
    let offset, limit: Int
    let photos: [Photo]

    var isStoryLiked: Bool = false

    enum CodingKeys: String, CodingKey {
        case success
        case totalPhotos = "total_photos"
        case message, offset, limit, photos
    }
}

// MARK: - Photo
struct Photo: Codable, Equatable {
    let url: String
    let user: Int
}
