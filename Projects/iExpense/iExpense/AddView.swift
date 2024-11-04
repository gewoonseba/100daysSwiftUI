//
//  AddView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 10/10/2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = "New expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    private let types = ["Personal", "Business", "Other"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        modelContext.insert(item)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView()
}
