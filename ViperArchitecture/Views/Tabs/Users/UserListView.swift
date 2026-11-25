//
//  UserListView.swift
//  ViperArchitecture
//

import SwiftUI

/// Users tab: owns the presenter and feeds the standalone `GenericListView`.
struct UserListView: View {
    @StateObject private var presenter: UserListPresenter

    init(presenter: UserListPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        NavigationStack {
            List(presenter.users) { user in
                NavigationLink(value: user) {
                    UserRow(user: user)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(USERS_TITLE)
            .navigationDestination(for: User.self) { user in
                UserListRouter.makeUserDetailView(user: user)
            }
            .onAppear { presenter.viewDidLoad() }
            .alert("Error", isPresented: Binding(
                get: { presenter.errorMessage != nil },
                set: { if !$0 { presenter.errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(presenter.errorMessage ?? "")
            }
        }
    }
}

private struct UserRow: View {
    let user: User

    private var initials: String {
        user.name.split(separator: " ").prefix(2)
            .compactMap { $0.first }.map(String.init).joined().uppercased()
    }

    var body: some View {
        HStack(spacing: Spacing.md) {
            Text(initials)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.accentColor)
                .frame(width: 40, height: 40)
                .background(Color.accentColor.opacity(0.12), in: Circle())
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(user.name)
                    .font(.headline.weight(.semibold))
                Text(user.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, Spacing.xs)
        .accessibilityElement(children: .combine)
    }
}
