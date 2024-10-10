//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 10/10/2024.

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
