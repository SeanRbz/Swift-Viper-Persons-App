//
//  APIClient.swift
//  ViperArchitecture
//

import Foundation

protocol APIClient {
    func get<T: Decodable>(_ path: String) async throws -> T
}

struct URLSessionAPIClient: APIClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func get<T: Decodable>(_ path: String) async throws -> T {
        try await session.get(path, decoder: decoder)
    }
}
