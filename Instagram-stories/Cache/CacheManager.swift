//
//  CacheManager.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import Foundation

struct CacheManager: CacheManagerProtocol {
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
}
