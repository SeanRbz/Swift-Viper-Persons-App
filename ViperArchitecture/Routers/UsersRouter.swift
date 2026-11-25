//
//  UsersRouter.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

import SwiftUI
import Swinject

final class UserListRouter {
    static func makeUserDetailView(user: User, resolver: Resolver = AppContainer.shared) -> some View {
        UserDetailView(
            user: user,
            activityPresenter: RecentActivityPresenter(
                userId: user.id,
                interactor: resolver.resolve(RecentActivityInteracting.self)!
            )
        )
    }
}
