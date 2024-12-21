//
//  ContentView.swift
//  Dicer
//
//  Created by Sebastian Stoelen on 21/12/2024.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Query(sort: \DiceRoll.rollTimestamp, order: .reverse) private var diceRolls: [DiceRoll]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List(diceRolls) { roll in
                HStack {
                    Text("Roll: \(roll.result ?? 0)")
                        .font(.title3)
                    Spacer()
                    Text(roll.rollTimestamp.formatted(date: .abbreviated, time: .shortened))
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Roll History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DiceRoll.rollTimestamp, order: .reverse) private var diceRolls: [DiceRoll]
    @State private var latestRoll: Int = 0
    @State private var showingHistory = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    Text("\(latestRoll)")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(.blue)

                    Spacer()

                    Button(action: rollDice) {
                        Text("Roll Dice")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .toolbar {
                Button {
                    showingHistory = true
                } label: {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
            }
            .sheet(isPresented: $showingHistory) {
                HistoryView()
            }
        }
    }

    func rollDice() {
        let newRoll = DiceRoll(sides: 6)
        newRoll.roll()
        modelContext.insert(newRoll)
        try? modelContext.save()

        latestRoll = newRoll.result!
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DiceRoll.self, configurations: config)

    // Add some sample data
    let sampleRolls = [
        DiceRoll(sides: 6),
        DiceRoll(sides: 6),
        DiceRoll(sides: 6),
    ]

    for roll in sampleRolls {
        _ = roll.roll()
        container.mainContext.insert(roll)
    }

    return ContentView()
        .modelContainer(container)
}
