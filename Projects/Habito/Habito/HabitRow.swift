//
//  HabitRow.swift
//  Habito
//
//  Created by Sebastian Stoelen on 22/10/2024.
//

import SwiftUI

struct HabitRow: View {
    @Binding var habit: Habit

    var body: some View {
        HStack {
            Text(habit.name)
                .font(.headline)
            Spacer()
            Text("\(habit.count)")
                .contentTransition(.numericText())
                .padding(.horizontal)
                .foregroundStyle(habit.count == 0 ? .secondary : .primary)
            Stepper("Count \(habit.count)", value: $habit.count, in: 0...Int.max)
                .labelsHidden()
        }
        .animation(.default, value: habit.count)
    }
}

#Preview {
    @Previewable @State var previewHabit = Habit(name: "Habit", description: "Test habit")
    return HabitRow(habit: $previewHabit)
}
