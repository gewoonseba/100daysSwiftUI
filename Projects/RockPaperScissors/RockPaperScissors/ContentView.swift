//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sebastian Stoelen on 26/09/2024.
//

import SwiftUI

enum GameOption {
  case rock
  case paper
  case scissors

  func image() -> String {
    switch self {
    case .rock: return "👊🏻"
    case .paper: return "✋🏻"
    case .scissors: return "✌🏻"
    }
  }
}

enum WinCondition {
  case win, lose
}

struct ContentView: View {
  
  private var winConditions: [WinCondition] = [.win, .lose]
  @State private var selectedWinCondition: WinCondition = .lose
  
  private var options: [GameOption] = [.rock, .paper, .scissors]
  @State private var selectedOption: GameOption = .rock
  
  @State private var userOption: GameOption = .rock
  
  var body: some View {
    VStack {
      Text("I want you to \(selectedWinCondition) from")
      Text("\(selectedOption.image())")
        .font(.largeTitle)
      Spacer()
      HStack {
        Spacer()
        ForEach(options, id: \.self) { option in
          Button(action: {
            userOption = option 
          }) {
            Text(option.image())
              .font(.title)
          }
          Spacer()
        }
      }
      
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
