//
//  HomeView.swift
//  ViperArchitecture
//

import SwiftUI

struct HomeView: View {
    let userListPresenter: UserListPresenter
    let photoListPresenter: PhotoListPresenter

    var body: some View {
        TabView {
            UserListView(presenter: userListPresenter)
                .tabItem { Label(USERS_TITLE, systemImage: "person.2") }
            
                PhotoListView(presenter: photoListPresenter)
                    .tabItem { Label(PHOTOS_TITLE, systemImage: "photo.on.rectangle") }

        }
        .tint(Color(red: 0, green: 0.478, blue: 1))
    }
}
