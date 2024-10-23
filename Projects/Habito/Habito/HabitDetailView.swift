//
//  HabitDetailView.swift
//  Habito
//
//  Created by Sebastian Stoelen on 22/10/2024.
//

import SwiftUI

struct HabitDetailView: View {
    @Binding var habit: Habit

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(habit.description)
                    .foregroundStyle(.secondary)

                VStack {
                    Text("\(habit.count)")
                        .contentTransition(.numericText())
                        .font(.system(size: 80, weight: .heavy, design: .rounded))
                        .foregroundStyle(habit.count == 0 ? .secondary : .primary)
                        .padding(.vertical, 40)

                    Stepper("Count \(habit.count)", value: $habit.count, in: 0 ... Int.max)
                        .labelsHidden()
                }
                .animation(.default, value: habit.count) //explicitly animating habit.count instead of the binding keeps it working in child views
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .padding()
            .navigationTitle(habit.name)
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Run a lot", description: "Dolor occaecat commodo in laborum enim nulla in irure reprehenderit magna ut amet.")
    HabitDetailView(habit: $habit)
}
