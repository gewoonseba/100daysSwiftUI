//
//  Student.swift
//  Bookworm
//
//  Created by Sebastian Stoelen on 29/10/2024.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
