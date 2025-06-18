//
//  UserStoryView.swift
//  Instagram-stories
//
//  Created by Aya on 18/06/2025.
//

import SwiftUI

struct UserStoryView: View {
    let user: User
    @State private var isLiked = false
    @Binding var isPresented: Bool

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topTrailing) {
                if let firstPhoto = user.photos.first {
                    AsyncImage(url: URL(string: firstPhoto.url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: geo.size.width, height: geo.size.height)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                        case .failure:
                            Color.gray
                                .frame(width: geo.size.width, height: geo.size.height)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Color.black
                    Text("No story available")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                VStack {
                    HStack {
                        Button {
                            isLiked.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(isLiked ? .red : .white)
                                .font(.title2)
                                .padding()
                        }

                        Spacer()

                        Button {
                            isPresented = false
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding()
                        }
                    }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    StoryFullView(
        users: [
            User(id: 1, name: "John Doe", profilePictureURL: "", photos: [
                Photo(url: "https://picsum.photos/400/700", user: 1)
            ]),
            User(id: 2, name: "Jane Smith", profilePictureURL: "", photos: [
                Photo(url: "https://picsum.photos/401/700", user: 2)
            ])
        ],
        startUserIndex: 0,
        isPresented: .constant(true)
    )
}
