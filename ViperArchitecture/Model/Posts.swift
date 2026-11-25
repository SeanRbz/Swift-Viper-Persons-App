//
//  Posts.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

struct Posts: Codable, Identifiable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
