//
//  ContentView.swift
//  WeSplit
//
//  Created by Sebastian Stoelen on 17/09/2024.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var amountIsfocused: Bool
  
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 0
  @State private var tipPercentage = 20

  private let availablePercentages = [0, 10, 15, 20, 25]
  
  var totalPerPerson: Double {
    let actualPeople = Double(numberOfPeople + 2)
    let totalIncludingTip = Double(checkAmount + (checkAmount * Double(tipPercentage) / 100))
    return totalIncludingTip / actualPeople
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .keyboardType(.decimalPad)
            .focused($amountIsfocused)

          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2 ..< 100) {
              Text("\($0) people")
            }
          }.pickerStyle(.automatic)
        }
        
        Section("How much do you want to tip?") {
        
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(availablePercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }.pickerStyle(.segmented)
        }

        Section {
          Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        if amountIsfocused {
          Button("Done") {
            amountIsfocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
