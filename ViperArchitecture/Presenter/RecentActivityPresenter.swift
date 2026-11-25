//
//  RecentActivityPresenter.swift
//  ViperArchitecture
//

import SwiftUI
import Combine

final class RecentActivityPresenter: ObservableObject {
    @Published var posts: [Posts] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var commentsByPost: [Int: [Comments]] = [:]
    @Published var expandedPostIds: Set<Int> = []
    @Published var loadingCommentPostIds: Set<Int> = []

    private let userId: Int
    private let interactor: RecentActivityInteracting
    private var hasLoaded = false

    init(userId: Int, interactor: RecentActivityInteracting) {
        self.userId = userId
        self.interactor = interactor
    }

    func viewDidLoad() {
        guard !hasLoaded else { return }
        hasLoaded = true
        isLoading = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer { self.isLoading = false }
            do {
                let posts = try await self.interactor.fetchPosts(userId: self.userId)
                self.posts = posts.sorted { $0.id > $1.id }
                self.errorMessage = nil
            } catch {
                self.hasLoaded = false
                self.errorMessage = error.localizedDescription
            }
        }
    }

    /// Expands or collapses a post's comments. Comments are fetched once, on first expand.
    func setExpanded(_ expanded: Bool, for post: Posts) {
        guard expanded else {
            expandedPostIds.remove(post.id)
            return
        }
        expandedPostIds.insert(post.id)
        guard commentsByPost[post.id] == nil, !loadingCommentPostIds.contains(post.id) else { return }

        loadingCommentPostIds.insert(post.id)
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer { self.loadingCommentPostIds.remove(post.id) }
            do {
                self.commentsByPost[post.id] = try await self.interactor.fetchComments(postId: post.id)
            } catch {
                self.expandedPostIds.remove(post.id)
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
