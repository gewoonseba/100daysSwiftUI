//
//  ContentView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 09/10/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    private static let nameFirstOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]
    private static let amountFirstOrder = [
        SortDescriptor(\ExpenseItem.amount),
        SortDescriptor(\ExpenseItem.name),
    ]

    @State private var sortOrder = ContentView.nameFirstOrder
    @State private var typeFilter: String = ""

    var body: some View {
        NavigationStack {
            ExpenseListView(sortOrder: sortOrder, typeFilter: typeFilter)
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                            AddView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem {
                        Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by name")
                                    .tag(ContentView.nameFirstOrder)

                                Text("Sort by amount")
                                    .tag(ContentView.amountFirstOrder)
                            }
                            
                            Picker("Filter", selection: $typeFilter) {
                                Text("All expenses")
                                    .tag("")
                                Text("Business expenses")
                                    .tag("Business")
                                Text("Personal expenses")
                                    .tag("Personal")
                                Text("Other expenses")
                                    .tag("Other")
                            }
                        }
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
    
    // Other expenses
    let nintendo = ExpenseItem(name: "Nintendo Switch", type: "Other", amount: 210)
    let lunch = ExpenseItem(name: "Mediocre lunch", type: "Other", amount: 16)
    let math = ExpenseItem(name: "Three times twelve", type: "Other", amount: 36)

    // Insert all example items
    container.mainContext.insert(dinner)
    container.mainContext.insert(shopping)
    container.mainContext.insert(movies)
    container.mainContext.insert(travel)
    container.mainContext.insert(hotel)
    container.mainContext.insert(taxi)
    container.mainContext.insert(nintendo)
    container.mainContext.insert(lunch)
    container.mainContext.insert(math)

    return ContentView()
        .modelContainer(container)
}
