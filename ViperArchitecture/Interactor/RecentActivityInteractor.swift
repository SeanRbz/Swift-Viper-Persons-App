//
//  RecentActivityInteractor.swift
//  ViperArchitecture
//

protocol RecentActivityInteracting {
    func fetchPosts(userId: Int) async throws -> [Posts]
    func fetchComments(postId: Int) async throws -> [Comments]
}

final class RecentActivityInteractor: RecentActivityInteracting {
    private let postsEndpoint: UsersEndpoint
    private let commentsEndpoint: CommentsEndpoint

    init(postsEndpoint: UsersEndpoint, commentsEndpoint: CommentsEndpoint) {
        self.postsEndpoint = postsEndpoint
        self.commentsEndpoint = commentsEndpoint
    }

    func fetchPosts(userId: Int) async throws -> [Posts] {
        try await postsEndpoint.fetchUserPosts(userId: userId)
    }

    func fetchComments(postId: Int) async throws -> [Comments] {
        try await commentsEndpoint.fetchPostComments(postId: postId)
    }
}
