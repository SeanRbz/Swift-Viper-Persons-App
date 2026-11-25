//
//  PhotoListView.swift
//  ViperArchitecture
//

import SwiftUI

struct PhotoListView: View {
    @StateObject private var presenter: PhotoListPresenter

    init(presenter: PhotoListPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: Spacing.lg) {
                    ForEach(presenter.photos) { photo in
                        CardView(
                            imageURL: URL(string: photo.thumbnailUrl),
                            title: photo.title,
                            shareURL: URL(string: photo.url)
                        )
                    }
                }
                .frame(maxWidth: Spacing.maxContentWidth)
                .padding(.horizontal, Spacing.md)
                .padding(.top, Spacing.sm)
                .padding(.bottom, Spacing.lg)
                .frame(maxWidth: .infinity)
            }
            .background(Color(.systemGroupedBackground))
            .overlay {
                if presenter.isLoading && presenter.photos.isEmpty {
                    ProgressView()
                }
            }
            .navigationTitle(PHOTOS_TITLE)
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
    }
}
