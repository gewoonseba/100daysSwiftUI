//
//  UserHabits.swift
//  Habito
//
//  Created by Sebastian Stoelen on 22/10/2024.
//

import Foundation

@Observable
class UserHabits {
    var habits: [Habit] {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }

    init() {
        if let encoded = UserDefaults.standard.data(forKey: "habits") {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: encoded) {
                habits = decoded
                return
            }
        }
        self.habits = []
    }
}
