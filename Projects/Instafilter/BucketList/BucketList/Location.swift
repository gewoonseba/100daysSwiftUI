//
//  Locaton.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 16/11/2024.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
