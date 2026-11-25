//
//  PhotoListInteractor.swift
//  ViperArchitecture
//

protocol PhotoListInteracting {
    func fetchPhotos() async throws -> [Photo]
}

final class PhotoListInteractor: PhotoListInteracting {
    private let endpoint: PhotosEndpoint

    init(endpoint: PhotosEndpoint) {
        self.endpoint = endpoint
    }

    func fetchPhotos() async throws -> [Photo] {
        try await endpoint.fetchPhotos()
    }
}
