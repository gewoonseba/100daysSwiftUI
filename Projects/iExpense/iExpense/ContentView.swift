//
//  ContentView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 09/10/2024.
//

import SwiftUI

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }

    init() {
        if let encoded = UserDefaults.standard.data(forKey: "items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: encoded) {
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ExpenseView: View {
    var item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(getColor(item.amount))
        }
    }

    func getColor(_ amount: Double) -> Color {
        if amount > 100 {
            .red
        } else if amount > 10 {
            .orange
        } else {
            .blue
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            let businessExpenses = expenses.items.filter { $0.type == "Business" }
            let personalExpenses = expenses.items.filter { $0.type == "Personal" }
            List {
                Section("Business") {
                    ForEach(businessExpenses) {
                        ExpenseView(item: $0)
                    }.onDelete(perform: removeItems)
                }

                Section("Personal") {
                    ForEach(personalExpenses) {
                        ExpenseView(item: $0)
                    }.onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
