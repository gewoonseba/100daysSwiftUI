//
//  User.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
