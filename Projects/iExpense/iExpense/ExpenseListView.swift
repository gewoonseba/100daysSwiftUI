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
    let typeFilter: String
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], typeFilter: String) {
        self.typeFilter = typeFilter
        if !typeFilter.isEmpty {
            _expenseItems = Query(filter: #Predicate<ExpenseItem> { expense in
                expense.type == typeFilter
            }, sort: sortOrder)
        } else {
            _expenseItems = Query(sort: sortOrder)
        }
    }
    
    var body: some View {
        let businessExpenses = expenseItems.filter { $0.type == "Business" }
        let personalExpenses = expenseItems.filter { $0.type == "Personal" }
        let otherExpenses = expenseItems.filter { $0.type == "Other" }
        
        List {
            if typeFilter.isEmpty || typeFilter == "Business" {
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
            }
            
            if typeFilter.isEmpty || typeFilter == "Personal" {
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
            
            if typeFilter.isEmpty || typeFilter == "Other" {
                Section("Other") {
                    if otherExpenses.isEmpty {
                        Text("No other expenses yet")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(otherExpenses) {
                        ExpenseView(item: $0)
                    }.onDelete(perform: { offsets in
                        removeItems(at: offsets, from: "Other")
                    })
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

#Preview {}
