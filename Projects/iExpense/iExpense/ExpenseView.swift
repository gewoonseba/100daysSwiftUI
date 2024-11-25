//
//  ExpenseView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 04/11/2024.
//

import SwiftUI

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
        .accessibilityElement()
        .accessibilityLabel(Text("\(item.name), \(item.amount)"))
        .accessibilityHint(Text("\(item.type)"))
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

#Preview {
    ExpenseView(item: ExpenseItem(name: "Test", type: "Food", amount: 100))
}
