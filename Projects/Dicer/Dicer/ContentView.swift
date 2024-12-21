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
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            VStack {
                List(diceRolls) { roll in
                    HStack {
                        Text("Roll: \(roll.result ?? 0)")
                            .font(.title3)
                        Spacer()
                        Text(roll.rollTimestamp.formatted(date: .abbreviated, time: .shortened))
                            .foregroundColor(.secondary)
                    }
                }

                if !diceRolls.isEmpty {
                    Button(role: .destructive) {
                        for roll in diceRolls {
                            modelContext.delete(roll)
                        }
                        try? modelContext.save()
                    } label: {
                        Text("Delete Roll History")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
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
    @State private var displayedResult: Int = 0
    @State private var showingHistory = false
    @State private var animationResults: [Int] = []
    @State private var isRolling = false

    // Create a single instance of the feedback generator
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    Text("\(displayedResult)")
                        .contentTransition(.numericText())
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(isRolling ? .gray : .blue)

                    Spacer()

                    Button(action: rollDice) {
                        Text("Roll Dice")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isRolling ? Color.gray : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(isRolling)
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
        .onAppear {
            // Prepare the generator when the view appears
            feedbackGenerator.prepare()
        }
    }

    func generateRandomSequence(sides: Int, count: Int) -> [Int] {
        (1 ... count).map { _ in Int.random(in: 1 ... sides) }
    }

    func rollDice() {
        guard !isRolling else { return }
        isRolling = true

        // Prepare the generator before the animation sequence
        feedbackGenerator.prepare()

        // Generate random sequence
        let randomSequence = generateRandomSequence(sides: 6, count: 25)

        // Create and roll the actual dice
        let newRoll = DiceRoll(sides: 6)
        newRoll.roll()

        // Combine random sequence with actual result
        animationResults = randomSequence + [newRoll.result!]

        // Start the animation sequence
        var index = 0

        func getInterval(_ i: Int) -> TimeInterval {
            // Start very fast and exponentially slow down
            return 0.01 * pow(1.15, Double(i))
        }

        func scheduleNext() {
            guard index < animationResults.count else {
                // Animation sequence complete
                modelContext.insert(newRoll)
                try? modelContext.save()
                isRolling = false
                return
            }

            Timer.scheduledTimer(withTimeInterval: getInterval(index), repeats: false) { _ in
                withAnimation {
                    displayedResult = animationResults[index]
                    // Trigger haptic feedback for each number change
                    feedbackGenerator.impactOccurred(intensity: index == animationResults.count - 1 ? 1.0 : 0.6)
                }

                index += 1
                scheduleNext()
            }
        }

        scheduleNext()
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
