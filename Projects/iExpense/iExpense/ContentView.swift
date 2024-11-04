//
//  ContentView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 09/10/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var expenseItems: [ExpenseItem]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
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
    
    let exampleItem = ExpenseItem(name: "Example Item", type: "Personal", amount: 100)
    container.mainContext.insert(exampleItem)
    
    return ContentView()
        .modelContainer(container)
}
