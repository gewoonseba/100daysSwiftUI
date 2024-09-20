//
//  ContentView.swift
//  Konvertaroo
//
//  Created by Sebastian Stoelen on 20/09/2024.
//

import SwiftUI

enum TemperatureUnit: CaseIterable, Identifiable {
  case Celsius
  case Farenheit
  case Kelvin

  var id: Self { self }

  var displayName: String {
    switch self {
    case .Celsius: return "°C"
    case .Farenheit: return "°F"
    case .Kelvin: return "°K"
    }
  }
}

struct ContentView: View {
  @State private var input: Double = 0
  @State private var inputUnit: TemperatureUnit = .Celsius
  @State private var outputUnit: TemperatureUnit = .Celsius
  private var output: Double {
    let inputInKelvin = convertToKelvin(value: input, unit: inputUnit)
    return convertToTargetUnit(valueInKelvin: inputInKelvin, targetUnit: outputUnit)
  }

  func convertToKelvin(value: Double, unit: TemperatureUnit) -> Double {
    switch unit {
    case .Celsius: return value + 273.15
    case .Farenheit: return (value + 459.67) * 5 / 9
    case .Kelvin: return value
    }
  }

  func convertToTargetUnit(valueInKelvin value: Double, targetUnit unit: TemperatureUnit) -> Double {
    switch unit {
    case .Celsius: return value - 273.15
    case .Farenheit: return (value * 9 / 5) - 459.67
    case .Kelvin: return value
    }
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("Input") {
          HStack {
            TextField("Input", value: $input, format: .number)
              .keyboardType(.numberPad)
            Spacer()
            Picker("", selection: $inputUnit) {
              ForEach(TemperatureUnit.allCases) {
                Text(String(describing: $0.displayName))
              }
            }
          }
        }

        Section("Output") {
          VStack {
            Text(String(output))
              .font(.largeTitle)
              .fontWeight(.bold)
              .multilineTextAlignment(.center)
              .padding(.all, 20)

            Picker("", selection: $outputUnit) {
              ForEach(TemperatureUnit.allCases) {
                Text(String(describing: $0.displayName))
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
