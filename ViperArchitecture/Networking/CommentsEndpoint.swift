//
//  CommentsEndpoint.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

struct CommentsEndpoint {
    let client: APIClient

    func fetchPostComments(postId: Int) async throws -> [Comments] {
        try await client.get("/comments?postId=\(postId)")
    }
}
