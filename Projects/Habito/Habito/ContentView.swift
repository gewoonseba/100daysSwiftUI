//
//  ContentView.swift
//  Habito
//
//  Created by Sebastian Stoelen on 22/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var userHabits = UserHabits()
    @State private var showAddHabit: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(userHabits.habits) { habit in
                    HabitRow(habit: habit)
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddHabit.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView(userHabits: userHabits)
            }
        }
    }
    
    func removeHabit(at offsets: IndexSet) {
        userHabits.habits.remove(atOffsets: offsets)
    }
}

struct HabitRow: View {
    let habit: Habit

    var body: some View {
        HStack {
            Text(habit.name)
        }
    }
}

struct AddHabitView: View {
    let userHabits: UserHabits
    @State var habitName: String = ""
    @State var habitDescription: String = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Habit Name", text: $habitName)
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
    ContentView()
}
