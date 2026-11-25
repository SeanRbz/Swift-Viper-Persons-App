//
//  Comments.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

struct Comments: Codable, Identifiable, Hashable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
