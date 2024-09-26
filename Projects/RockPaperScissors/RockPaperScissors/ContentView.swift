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
  case win, lose, draw
}

struct ContentView: View {
  private var winConditions: [WinCondition] = [.win, .lose]
  @State private var selectedWinCondition: WinCondition = .lose

  private var options: [GameOption] = [.rock, .paper, .scissors]
  @State private var gameOption: GameOption = .rock
  @State private var playerScore = 0
  @State private var gamesPlayed = 0
  @State private var showingFinalScore = false

  var body: some View {
    VStack {
      Spacer()
      HStack {
        Text("I want you to")
        Text("\(selectedWinCondition)")
          .foregroundStyle(selectedWinCondition == . lose ? .red : .green)
          .fontWeight(.bold)
        Text("from")
      }
      Text("\(gameOption.image())")
        .font(.largeTitle)
      Text("Score: \(playerScore)")
      Spacer()
      HStack {
        Spacer()
        ForEach(options, id: \.self) { option in
          Button(action: {
            evaluateResult(option)
          }) {
            Text(option.image())
              .font(.title)
          }
          Spacer()
        }
      }
    }
    .padding()
    .alert("Final Score", isPresented: $showingFinalScore) {
      Button("Replay") {
        gamesPlayed = 0
        playerScore = 0
        nextRound()
      }
    } message: {
      Text("Your final score is \(playerScore) / \(gamesPlayed)")
    }
  }

  func evaluateResult(_ option: GameOption) {
    let playerResult = getPlayerResult(player: option, game: gameOption)
    print(playerResult)
    if playerResult == selectedWinCondition {
      playerScore += 1
    }
    gamesPlayed += 1
    nextRound()
  }

  func nextRound() {
    if gamesPlayed >= 10 {
      showingFinalScore = true
    }
    gameOption = options.randomElement() ?? .paper
    selectedWinCondition = winConditions.randomElement() ?? .lose
  }
}

func getPlayerResult(player: GameOption, game: GameOption) -> WinCondition {
  switch (player, game) {
  case (.rock, .paper): return .lose
  case (.rock, .scissors): return .win
  case (.paper, .rock): return .win
  case (.paper, .scissors): return .lose
  case (.scissors, .rock): return .lose
  case (.scissors, .paper): return .win
  default: return .draw
  }
}

#Preview {
  ContentView()
}
