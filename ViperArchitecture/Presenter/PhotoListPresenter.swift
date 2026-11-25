//
//  PhotoListPresenter.swift
//  ViperArchitecture
//

import SwiftUI
import Combine

final class PhotoListPresenter: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let interactor: PhotoListInteracting

    init(interactor: PhotoListInteracting) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        guard photos.isEmpty, !isLoading else { return }
        isLoading = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer { self.isLoading = false }
            do {
                self.photos = try await self.interactor.fetchPhotos()
                self.errorMessage = nil
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
