//
//  Photo.swift
//  ViperArchitecture
//

struct Photo: Codable, Identifiable, Hashable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
