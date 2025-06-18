//
//  StoryFullView.swift
//  Instagram-stories
//
//  Created by Aya on 16/06/2025.
//

import SwiftUI

struct StoryFullView: View {
    let users: [User]
    @State private var currentUserIndex: Int
    @Binding var isPresented: Bool

    init(users: [User], startUserIndex: Int, isPresented: Binding<Bool>) {
        self.users = users
        self._currentUserIndex = State(initialValue: startUserIndex)
        self._isPresented = isPresented
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()

            TabView(selection: $currentUserIndex) {
                ForEach(users.indices, id: \.self) { index in
                    UserStoryView(user: users[index], isPresented: $isPresented)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}
