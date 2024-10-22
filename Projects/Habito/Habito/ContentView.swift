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
            if userHabits.habits.isEmpty {
                HStack {
                    Text("Add a new habit with the")
                    Image(systemName: "plus")
                    Text("button.")
                }
                .padding(.all, 40)
                .foregroundStyle(.secondary)
            }
            List {
                //By adding the $ sign in the foreach, there is created a binding for each habit
                ForEach($userHabits.habits) { $habit in
                    NavigationLink{
                        HabitDetailView(habit: $habit)
                    } label: {
                        HabitRow(habit: $habit)
                    }
                    
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habito")
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

#Preview {
    ContentView()
}
