//
//  Habit.swift
//  Habito
//
//  Created by Sebastian Stoelen on 22/10/2024.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int = 0
}
