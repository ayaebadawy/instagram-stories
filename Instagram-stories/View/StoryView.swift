//
//  StoryView.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import SwiftUI

struct StoryView: View {
    
    var user: User
    var viewModel: UserViewModel

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(
                        !user.isStorySeen ? LinearGradient(
                            colors: [.red, .orange, .yellow, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing) : LinearGradient(
                                colors: [.gray],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                        lineWidth: 4
                    )
                    .frame(width: 120, height: 120)
                if let url = viewModel.convertImageStringToURL(user.profilePictureURL) {
                    AsyncImage(url: url)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                
            }
            
            Text(user.name)
                .font(.footnote)
                .truncationMode(.tail)
                .frame(width: 100)
        }
    }
}
