//
//  UsersEndpoint.swift
//  ViperArchitecture
//

struct UsersEndpoint {
    let client: APIClient

    func fetchUsers() async throws -> [User] {
        try await client.get("/users")
    }
    
    func fetchUserPosts(userId: Int) async throws -> [Posts] {
        try await client.get("/posts?userId=\(userId)")
    }
}
