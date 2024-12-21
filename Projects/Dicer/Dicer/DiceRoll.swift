//
//  DiceRoll.swift
//  Dicer
//
//  Created by Sebastian Stoelen on 21/12/2024.
//

import SwiftData
import Foundation

@Model
class DiceRoll {
    var rollTimestamp: Date = Date()
    var sides: Int
    var result: Int?
    
    init(sides: Int) {
        self.sides = sides
    }
    
    func roll() {
        result = Int.random(in: 1...sides)
    }
    
}
