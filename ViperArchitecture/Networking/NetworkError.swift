//
//  NetworkError.swift
//  ViperArchitecture
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case badStatus(Int)
}
