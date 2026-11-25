//
//  UserDetailView.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    let activityPresenter: RecentActivityPresenter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                profileHeader
                RecentActivityView(presenter: activityPresenter)
            }
            .frame(maxWidth: Spacing.maxContentWidth, alignment: .leading)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(USER_DETAILS_TITLE)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var profileHeader: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.md) {
                Text(initials)
                    .font(.headline)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 48, height: 48)
                    .background(Color.accentColor.opacity(0.12), in: Circle())
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 2) {
                    Text("USER PROFILE")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Text(user.name)
                        .font(.title.bold())
                        .lineLimit(2)
                }
            }

            Text(user.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }

    private var initials: String {
        user.name.split(separator: " ").prefix(2)
            .compactMap { $0.first }.map(String.init).joined().uppercased()
    }
}
