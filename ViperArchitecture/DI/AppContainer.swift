//
//  AppContainer.swift
//  ViperArchitecture
//

import Swinject

enum AppContainer {
    static let shared: Container = makeContainer()

    static func makeContainer() -> Container {
        let container = Container()

        container.register(APIClient.self) { _ in
            URLSessionAPIClient()
        }
        .inObjectScope(.container)

        container.register(UsersEndpoint.self) { resolver in
            UsersEndpoint(client: resolver.resolve(APIClient.self)!)
        }
        container.register(PhotosEndpoint.self) { resolver in
            PhotosEndpoint(client: resolver.resolve(APIClient.self)!)
        }
        container.register(CommentsEndpoint.self) { resolver in
            CommentsEndpoint(client: resolver.resolve(APIClient.self)!)
        }

        container.register(UserListInteracting.self) { resolver in
            UserListInteractor(endpoint: resolver.resolve(UsersEndpoint.self)!)
        }
        container.register(PhotoListInteracting.self) { resolver in
            PhotoListInteractor(endpoint: resolver.resolve(PhotosEndpoint.self)!)
        }
        container.register(RecentActivityInteracting.self) { resolver in
            RecentActivityInteractor(
                postsEndpoint: resolver.resolve(UsersEndpoint.self)!,
                commentsEndpoint: resolver.resolve(CommentsEndpoint.self)!
            )
        }

        return container
    }
}
