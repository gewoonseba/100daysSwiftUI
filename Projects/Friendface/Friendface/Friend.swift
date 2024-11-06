//
//  Friend.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    var id: String
    var name: String

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
