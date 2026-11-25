//
//  RecentActivityView.swift
//  ViperArchitecture
//

import SwiftUI

/// Subview of `UserDetailView`: recent posts for one user.
struct RecentActivityView: View {
    @StateObject private var presenter: RecentActivityPresenter

    init(presenter: RecentActivityPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(alignment: .firstTextBaseline) {
                Text(RECENT_POSTS_TITLE)
                    .font(.title2.bold())
                Spacer()
                if !presenter.posts.isEmpty {
                    Text("\(presenter.posts.count) total")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }

            content
        }
        .onAppear {
            presenter.viewDidLoad()
        }
        .alert("Error", isPresented: Binding(
            get: { presenter.errorMessage != nil },
            set: { if !$0 { presenter.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(presenter.errorMessage ?? "")
        }
    }

    @ViewBuilder
    private var content: some View {
        let isEmpty = presenter.posts.isEmpty

        if presenter.isLoading && isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.lg)
        } else if isEmpty {
            Text("Nothing to show yet.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.lg)
        } else {
            LazyVStack(spacing: Spacing.md) {
                ForEach(Array(presenter.posts.enumerated()), id: \.element.id) { index, post in
                    postCard(post, number: index + 1)
                }
            }
        }
    }

    private func postCard(_ post: Posts, number: Int) -> some View {
        let isExpanded = presenter.expandedPostIds.contains(post.id)

        return VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("POST #\(number)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.accentColor)
                Text(post.title)
                    .font(.headline.weight(.semibold))
                Text(post.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
            .padding(Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .combine)

            Divider()

            Button {
                presenter.setExpanded(!isExpanded, for: post)
            } label: {
                commentsHeader(for: post, isExpanded: isExpanded)
            }
            .buttonStyle(.plain)

            if isExpanded {
                commentsList(for: post)
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator).opacity(0.5), lineWidth: 0.5)
        )
    }

    private func commentsHeader(for post: Posts, isExpanded: Bool) -> some View {
        let count = presenter.commentsByPost[post.id]?.count

        return HStack(spacing: Spacing.sm) {
            Image(systemName: isExpanded ? "bubble.left.fill" : "bubble.left")
                .foregroundStyle(Color.accentColor)

            if isExpanded {
                Text("Comments")
                    .font(.subheadline.weight(.semibold))
                if let count {
                    Text("\(count)")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Color.accentColor.opacity(0.12), in: Capsule())
                }
            } else {
                Text(count.map { "\(VIEW_COMMENTS_TITLE) (\($0))" } ?? VIEW_COMMENTS_TITLE)
                    .font(.subheadline.weight(.semibold))
            }

            Spacer()

            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(Color.accentColor)
        .padding(Spacing.md)
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private func commentsList(for post: Posts) -> some View {
        Group {
            if presenter.loadingCommentPostIds.contains(post.id) {
                HStack(spacing: Spacing.sm) {
                    ProgressView()
                    Text("Loading comments...")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            } else if let comments = presenter.commentsByPost[post.id] {
                if comments.isEmpty {
                    Text("No comments yet.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        ForEach(comments) { comment in
                            CommentRowView(comment: comment)
                        }
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color(.secondarySystemBackground))
    }
}

private struct CommentRowView: View {
    let comment: Comments

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(comment.name)
                .font(.subheadline.bold())
            Text(comment.body)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}
