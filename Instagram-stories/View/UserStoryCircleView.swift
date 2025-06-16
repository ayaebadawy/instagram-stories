//
//  StoryView.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import SwiftUI

struct UserStoryCircleView: View {
    @State var viewModel = UserViewModel()
    @State var isFullStoryPresented = false
    @State private var selectedUserIndex: Int = 0
    
    private let storyCircle = LinearGradient(
        colors: [.red, .orange, .yellow, .purple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack (spacing: 24) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(viewModel.users) { user in
                        StoryView(user: user,
                                  viewModel: viewModel)
                        .onAppear {
                            if user == viewModel.users.last && !viewModel.isLoading && !viewModel.reachedEnd {
                                Task {
                                    await viewModel.fetchMoreUsers()
                                }
                            }
                        }
                        .onTapGesture {
                            if let index = viewModel.users.firstIndex(
                                of: user
                            ) {
                                selectedUserIndex = index
                                isFullStoryPresented = true
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .task {
            await viewModel.fetchPhotos()
            await viewModel.fetchUsers()
        }
        .fullScreenCover(isPresented: $isFullStoryPresented) {
                StoryFullView(
                    users: viewModel.users,
                    startUserIndex: selectedUserIndex,
                    isPresented: $isFullStoryPresented
                )
        }
    }
}

#Preview {
    UserStoryCircleView()
}

