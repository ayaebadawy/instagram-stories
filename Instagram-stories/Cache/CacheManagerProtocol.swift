//
//  CacheManagerProtocol.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//


import Foundation

protocol CacheManagerProtocol {
    func getData<T: Codable>(as type: T.Type) throws -> [T]
    func saveData<T: Codable>(_ data: [T])
    func invalidate()
    
    var filename: String { get }
}

extension CacheManagerProtocol {
    
    var documentDirURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func getData<T: Codable>(as type: T.Type) throws -> [T] {
        
        guard let fileUrl = documentDirURL?.appending(path: filename) else { return [] }
        guard FileManager.default.fileExists(atPath: fileUrl.path) else { return [] }
        let data = try Data(contentsOf: fileUrl)
        return try JSONDecoder().decode([T].self, from: data)
    }
    
    func saveData<T: Codable>(_ data: [T]) {
        guard let fileUrl = documentDirURL?.appending(path: filename) else { return }
        
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: fileUrl)
        } catch {
            print("Failed to save data") // or log
        }
    }
    
    func invalidate() {
        guard let fileURL = documentDirURL?.appending(path: filename) else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Failed to save data \(error.localizedDescription)") // or log
        }
    }
}
