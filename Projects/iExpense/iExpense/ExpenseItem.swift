//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 10/10/2024.
import SwiftData
import Foundation

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
