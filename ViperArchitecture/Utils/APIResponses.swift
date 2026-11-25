//
//  URLSession+Get.swift
//  ViperArchitecture
//

import Foundation

extension URLSession {
    func get<T: Decodable>(_ path: String, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        guard let url = URL(string: BASE_URL + path) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await self.data(from: url)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.badStatus(http.statusCode)
        }
        return try decoder.decode(T.self, from: data)
    }
}
