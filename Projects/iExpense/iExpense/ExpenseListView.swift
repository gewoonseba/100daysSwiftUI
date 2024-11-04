//
//  ExpenseListView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 04/11/2024.
//
import SwiftData
import SwiftUI

struct ExpenseListView: View {
    @Query var expenseItems: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        let businessExpenses = expenseItems.filter { $0.type == "Business" }
        let personalExpenses = expenseItems.filter { $0.type == "Personal" }
        
        List {
            Section("Business") {
                if businessExpenses.isEmpty {
                    Text("No business expenses yet")
                        .foregroundStyle(.secondary)
                }
                ForEach(businessExpenses) {
                    ExpenseView(item: $0)
                }.onDelete(perform: { offsets in
                    removeItems(at: offsets, from: "Business")
                })
            }
            
            Section("Personal") {
                if personalExpenses.isEmpty {
                    Text("No personal expenses yet")
                        .foregroundStyle(.secondary)
                }
                ForEach(personalExpenses) {
                    ExpenseView(item: $0)
                }.onDelete(perform: { offsets in
                    removeItems(at: offsets, from: "Personal")
                })
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, from type: String) {
        let corretExpenseTypes = expenseItems.filter { $0.type == type }
        for offset in offsets {
            let itemToDelete = corretExpenseTypes[offset]
            modelContext.delete(itemToDelete)
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
    
    return ExpenseListView()
        .modelContainer(container)
}
