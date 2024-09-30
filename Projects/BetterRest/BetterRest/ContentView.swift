//
//  ContentView.swift
//  BetterRest
//
//  Created by Sebastian Stoelen on 27/09/2024.
//
import CoreML
import SwiftUI

struct ContentView: View {
  @State private var wakeUp = Date.now
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1

  var body: some View {
    NavigationStack {
      VStack {
        Text("When do you want to wake up?")
          .font(.headline)
        DatePicker("Plese enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
          .labelsHidden()

        Text("Desired amount of sleep")
          .font(.headline)
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)

        Text("Daily coffee intake")
          .font(.headline)

        Stepper("\(coffeeAmount) cups", value: $coffeeAmount, in: 0...20)
      }
      .navigationTitle("BetterRest")
      .toolbar {
        Button("Calculate", action: calculateBedtime)
      }
    }
  }

  func calculateBedtime() {
    do {
      let config = MLModelConfiguration()
      let model = try SleepCalculator(configuration: config)
      
      let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
      let hourInSeconds = (components.hour ?? 0) * 60 * 60
      let minuteInSeconds = (components.minute ?? 0) * 60
      let secondsFromMidnight = Double(hourInSeconds + minuteInSeconds)
      
      let prediction = try model.prediction(wake: secondsFromMidnight, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      
      //video timestamp 09:07
      
    } catch {
      
    }
  }
}

#Preview {
  ContentView()
}
