//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 09/10/2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: ExpenseItem.self)
    }
}
