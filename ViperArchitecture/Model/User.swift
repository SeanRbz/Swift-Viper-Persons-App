//
//  Users.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//
struct User: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let email: String
}
