//
//  HomeRouter.swift
//  ViperArchitecture
//

import SwiftUI
import Swinject

final class HomeRouter {
    static func makeHomeView(resolver: Resolver = AppContainer.shared) -> some View {
        let userListPresenter = UserListPresenter(
            interactor: resolver.resolve(UserListInteracting.self)!,
            router: UserListRouter()
        )
        let photoListPresenter = PhotoListPresenter(
            interactor: resolver.resolve(PhotoListInteracting.self)!
        )
        return HomeView(
            userListPresenter: userListPresenter,
            photoListPresenter: photoListPresenter
        )
    }
}
