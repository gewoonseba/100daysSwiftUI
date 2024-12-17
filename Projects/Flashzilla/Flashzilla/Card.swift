//
//  Card.swift
//  Flashzilla
//
//  Created by Sebastian Stoelen on 12/12/2024.
//

import Foundation

struct Card: Codable, Identifiable {
    let id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What is 2 + 2?", answer: "4")
}
