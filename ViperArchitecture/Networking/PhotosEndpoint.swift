//
//  PhotosEndpoint.swift
//  ViperArchitecture
//

struct PhotosEndpoint {
    let client: APIClient

    func fetchPhotos() async throws -> [Photo] {
        try await client.get("/photos")
    }
}
