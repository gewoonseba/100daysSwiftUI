//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sebastian Stoelen on 21/09/2024.
//

import SwiftUI

struct FlagImage: View {
  var imageName: String
  var rotationAmount: Double

  var body: some View {
    Image(imageName)
      .clipShape(.rect(cornerRadius: 6))
      .shadow(radius: 12)
      .rotation3DEffect(
        .degrees(rotationAmount),
        axis: (x: 1, y: 0, z: 0)
      )
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle.bold())
      .foregroundStyle(.white)
  }
}

extension View {
  func title() -> some View {
    modifier(Title())
  }
}

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0 ... 2)

  @State private var score = 0
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var scoreMessage = ""

  private static let maxRounds = 8
  @State private var roundsLeft = maxRounds
  @State private var showingFinalScore = false

  @State private var rotationAmount = 0.0

  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 3.5),
      ], center: .top, startRadius: 200, endRadius: 400)
        .ignoresSafeArea()

      VStack {
        Spacer()
        Text("Guess the Flag")
          .title()

        Spacer()
        Spacer()
        Text("Score: \(score)")
          .font(.title)
          .foregroundStyle(.white)
        Text("Rounds left: \(roundsLeft)")
          .foregroundStyle(.white)
          .opacity(0.6)

        Spacer()

        VStack(spacing: 16) {
          VStack {
            Text("Tap the flag of")
              .font(.subheadline.weight(.regular))
              .foregroundStyle(.secondary)
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }

          ForEach(0 ..< 3) { number in
            Button {
              flagTapped(number)
            } label: {
              FlagImage(imageName: countries[number], rotationAmount: rotationAmount)
            }
          }
        }.frame(maxWidth: .infinity)
          .padding(.vertical, 32)
          .background(.thinMaterial)
          .clipShape(.rect(cornerRadius: 20))
      }.padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: startNextRound)
    } message: {
      Text(scoreMessage)
    }
    .alert("Game over", isPresented: $showingFinalScore) {
      Button("Play again", action: resetGame)
    } message: {
      Text("Thank you for playing. Your final score is \(score).")
    }
  }

  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct!"
      score += 1
      scoreMessage = "You got it! You're score is \(score)"
    } else {
      scoreTitle = "Oops.."
      scoreMessage = "That's the flag of \(countries[number])"
    }
    showingScore = true
    rotationAmount = 0
  }

  func startNextRound() {
    roundsLeft -= 1
    if roundsLeft <= 0 {
      endGame()
    } else {
      continueGame()
    }
  }

  func endGame() {
    showingFinalScore = true
  }

  func continueGame() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0 ... 2)
    withAnimation(.easeInOut(duration: 1)) {
      rotationAmount += 360
    }
  }

  func resetGame() {
    roundsLeft = ContentView.maxRounds
    score = 0
    continueGame()
  }
}

#Preview {
  ContentView()
}
