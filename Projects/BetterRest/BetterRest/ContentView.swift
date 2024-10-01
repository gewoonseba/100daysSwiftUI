//
//  ContentView.swift
//  BetterRest
//
//  Created by Sebastian Stoelen on 27/09/2024.
//
import CoreML
import SwiftUI

struct ContentView: View {
  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  
  @State private var alerTitle = ""
  @State private var alertMessage = ""
  @State private var showAlert = false
  
  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? .now
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("When do you want to wake up?") {
          DatePicker("Plese enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
        }
        
        Section("Desired amount of sleep") {
          Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }
        
        Section("Daily coffee intake") {
          Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20)
          //          Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
          //            ForEach(0..<21) {
          //              Text("^[\($0) cup](inflect: true)")
          //            }
          //          }
        }
        
        Section {
          HStack {
            Spacer()
            VStack(alignment: .center) {
              Text("Your ideal bedtime is:")
              Text("\(calculateBedtime())")
                .font(.largeTitle)
                .bold()
            }
            Spacer()
          }
        }
        .navigationTitle("BetterRest")
        .alert(alerTitle, isPresented: $showAlert) {
          Button("OK") {}
        } message: {
          Text(alertMessage)
        }
      }
    }
  }

  func calculateBedtime() -> String {
    do {
      let config = MLModelConfiguration()
      let model = try SleepCalculator(configuration: config)
      
      let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
      let hourInSeconds = (components.hour ?? 0) * 60 * 60
      let minuteInSeconds = (components.minute ?? 0) * 60
      let secondsFromMidnight = Double(hourInSeconds + minuteInSeconds)
      
      let prediction = try model.prediction(wake: secondsFromMidnight, estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      
      let sleepTime = wakeUp - prediction.actualSleep
    
      return sleepTime.formatted(date: .omitted, time: .shortened)
    } catch {
      alerTitle = "Error"
      alertMessage = "There was an issue caclulating your bedtime"
      showAlert = true
      return "Unknown"
    }
  }
}

#Preview {
  ContentView()
}
