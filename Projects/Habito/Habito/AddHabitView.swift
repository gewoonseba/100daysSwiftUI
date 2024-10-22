//
//  AddHabitView.swift
//  Habito
//
//  Created by Sebastian Stoelen on 22/10/2024.
//

import SwiftUI

struct AddHabitView: View {
    let userHabits: UserHabits
    @State var habitName: String = ""
    @State var habitDescription: String = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $habitName)
                TextField("Description", text: $habitDescription)
            }
            .navigationTitle("Add Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addHabit()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    func addHabit() {
        userHabits.habits.append(Habit(name: habitName, description: habitDescription))
    }
}

#Preview {
    AddHabitView(userHabits: UserHabits())
}
