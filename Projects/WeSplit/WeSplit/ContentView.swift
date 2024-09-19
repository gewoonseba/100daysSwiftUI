//
//  ContentView.swift
//  WeSplit
//
//  Created by Sebastian Stoelen on 17/09/2024.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var amountIsfocused: Bool

  @State private var checkAmount: Double?
  @State private var numberOfPeople = 0
  @State private var tipPercentage = 20

  private let availablePercentages = 0...100
  
  var totalIncludingTip: Double {
    if let checkAmount {
      return checkAmount + (checkAmount * Double(tipPercentage) / 100)
    } else {
      return 0
    }
    
  }

  var totalPerPerson: Double {
    let actualPeople = Double(numberOfPeople + 2)
    return totalIncludingTip / actualPeople
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("Check details") {
          HStack {
            Text("Check amount")
            Spacer()
            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
              .focused($amountIsfocused)
              .onChange(of: amountIsfocused) {
                if amountIsfocused {
                  $checkAmount.wrappedValue = nil
                }
              }
          }
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2 ..< 100) {
              Text("\($0) people")
            }
          }.pickerStyle(.automatic)
          
          Picker("Desired tip", selection: $tipPercentage) {
            ForEach(availablePercentages, id: \.self){
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.navigationLink)
        }

        Section("Payment details") {
          HStack {
            Text("Total including tip")
            Spacer()
            Text(totalIncludingTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
          HStack {
            Text("Total per person")
            Spacer()
            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
          
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
