//
//  UserModel.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

struct UserResponse: Codable {
    let success: Bool
    let users: [User]
    let totalUsers: Int

    enum CodingKeys: String, CodingKey {
        case success, users
        case totalUsers = "total_users"
    }
}

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let profilePictureURL: String
    
    var photos = [Photo]()
    var isStorySeen: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "first_name"
        case profilePictureURL = "profile_picture"
    }
}
