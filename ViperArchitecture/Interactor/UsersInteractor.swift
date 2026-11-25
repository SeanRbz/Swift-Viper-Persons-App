//
//  UserListInteractor.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

protocol UserListInteracting {
    func fetchUsers() async throws -> [User]
}

final class UserListInteractor: UserListInteracting {
    private let endpoint: UsersEndpoint

    init(endpoint: UsersEndpoint) {
        self.endpoint = endpoint
    }

    func fetchUsers() async throws -> [User] {
        try await endpoint.fetchUsers()
    }
}
