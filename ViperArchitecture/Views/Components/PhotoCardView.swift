//
//  CardView.swift
//  ViperArchitecture
//

import SwiftUI

/// Reusable list card: optional image on top, optional title below.
/// What is shown defaults to the flags in `Constants.swift` and can be overridden per use.
struct CardView: View {
    let imageURL: URL?
    let title: String
    var subtitle: String? = nil
    var shareURL: URL? = nil
    var showImage: Bool = SHOW_CARD_IMAGE
    var showTitle: Bool = SHOW_CARD_TITLE

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if showImage {
                Color(.tertiarySystemFill)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable().scaledToFill()
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.secondary)
                            default:
                                ProgressView()
                            }
                        }
                    }
                    .clipped()
            }

            if showTitle {
                HStack(alignment: .top, spacing: Spacing.md) {
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(title)
                            .font(.headline.weight(.semibold))
                            .lineLimit(2)
                        if let subtitle {
                            Text(subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(3)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if let shareURL {
                        ShareLink(item: shareURL) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityLabel("Share")
                    }
                }
                .padding(Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
    }
}
