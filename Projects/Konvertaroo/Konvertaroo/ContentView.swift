//
//  ContentView.swift
//  Konvertaroo
//
//  Created by Sebastian Stoelen on 20/09/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var rawInput: Double = 0
  @State private var inputUnit: UnitTemperature = .celsius
  private let tempUnitOptions: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
  private var inputMeasurement: Measurement<UnitTemperature> {
    Measurement(value: rawInput, unit: inputUnit)
  }

  @State private var outputUnit: UnitTemperature = .celsius
  private var output: Measurement<UnitTemperature> {
    inputMeasurement.converted(to: outputUnit)
  }
  
  func formatTemperature(_ temperature: Measurement<UnitTemperature>) -> String {
      let formatter = MeasurementFormatter()
      formatter.unitOptions = .providedUnit // This ensures we use the unit of the measurement
      formatter.numberFormatter.maximumFractionDigits = 2
      formatter.numberFormatter.minimumFractionDigits = 0 // This allows whole numbers to be displayed without decimal places
      
      return formatter.string(from: temperature)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("Input") {
          HStack {
            TextField("Input", value: $rawInput, format: .number)
              .keyboardType(.numberPad)
            Spacer()
            Picker("", selection: $inputUnit) {
              ForEach(tempUnitOptions, id: \.self) { unit in
                Text(unit.symbol).tag(unit)
              }
            }
          }
        }

        Section("Output") {
          VStack {
            Text(formatTemperature(output))
              .font(.largeTitle)
              .fontWeight(.bold)
              .multilineTextAlignment(.center)
              .padding(.all, 20)

            Picker("", selection: $outputUnit) {
              ForEach(tempUnitOptions, id: \.self) { unit in
                Text(unit.symbol).tag(unit)
              }
            }
            .pickerStyle(.segmented)
          }
        }

      }.navigationTitle("Konvertaroo")
    }
  }
}

#Preview {
  ContentView()
}
