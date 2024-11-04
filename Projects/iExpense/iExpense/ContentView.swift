//
//  ContentView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 09/10/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ExpenseListView()
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink {
                        AddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExpenseItem.self, configurations: config)
    
    // Personal expenses
    let dinner = ExpenseItem(name: "Dinner", type: "Personal", amount: 45)
    let shopping = ExpenseItem(name: "Groceries", type: "Personal", amount: 85)
    let movies = ExpenseItem(name: "Cinema tickets", type: "Personal", amount: 25)
    
    // Business expenses
    let travel = ExpenseItem(name: "Flight tickets", type: "Business", amount: 350)
    let hotel = ExpenseItem(name: "Hotel stay", type: "Business", amount: 200)
    let taxi = ExpenseItem(name: "Taxi rides", type: "Business", amount: 30)
    
    // Insert all example items
    container.mainContext.insert(dinner)
    container.mainContext.insert(shopping)
    container.mainContext.insert(movies)
    container.mainContext.insert(travel)
    container.mainContext.insert(hotel)
    container.mainContext.insert(taxi)
    
    return ContentView()
        .modelContainer(container)
}
