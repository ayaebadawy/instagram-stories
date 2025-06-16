//
//  UserViewModel.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import Foundation

@MainActor
@Observable
class UserViewModel {
    
    var users = [User]()
    var contentLoadingError = ""
    var isLoading = false
    
    private var totalUsers: Int = 1000
    private let service: HTTPDataDownloader
    private var photos = [Photo]()
    private let pageSize = 30
    private var currentUserOffset = 0
    
    var groupedPhotos: [Int: [Photo]] = [:]
    
    var reachedEnd: Bool {
        users.count == totalUsers
    }
    
    init(service: HTTPDataDownloader = HTTPDataDownloader()) {
        self.service = service
    }
    
    func fetchMoreUsers() async {
        if !reachedEnd {
            isLoading = true
            defer { isLoading = false }
            do {
                currentUserOffset += pageSize
                let nextPageOfUsers = try await service.getUsers(withOffset: currentUserOffset)
                let usersWithPhotos = assignPhotosToUsers(users: nextPageOfUsers, photos: photos)
                users.append(contentsOf: usersWithPhotos)
            } catch {
                contentLoadingError = error.localizedDescription
            }
        }
    }
    
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let fetchedUsers = try await service.getUsers()
            print("Photos count: \(photos.count)")  // <--- check this

            users = assignPhotosToUsers(users: fetchedUsers, photos: photos)
            print(users)
        } catch {
            contentLoadingError = error.localizedDescription
        }
    }
    
    func convertImageStringToURL(_ string: String) -> URL? {
        guard let url = URL(string: string) else { return nil }
        return url
    }
    
    func fetchPhotos() async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.photos = try await service.getPhotos()
            print("photos \(photos)")
        } catch {
            contentLoadingError = error.localizedDescription
        }
    }
    
    func assignPhotosToUsers(users: [User], photos: [Photo]) -> [User] {
        guard !users.isEmpty, !photos.isEmpty else { return users }
        
        var usersWithPhotos = users
        let shuffledPhotos = photos.shuffled()
        var photoIndex = 0
        
        for i in 0..<usersWithPhotos.count {
            let photoCount = Int.random(in: 1...3)
            var assignedPhotos = [Photo]()
            
            for _ in 0..<photoCount {
                let photo = shuffledPhotos[photoIndex % shuffledPhotos.count]
                assignedPhotos.append(photo)
                photoIndex += 1
            }
            usersWithPhotos[i].photos = assignedPhotos
            print("in photos \(usersWithPhotos)")
        }
        
        return usersWithPhotos
    }
}
