//
//  ContentView.swift
//  Mulitplio
//
//  Created by Sebastian Stoelen on 08/10/2024.
//

import SwiftUI

struct QuestionAndAnswer {
  var question: String
  var answer: Int
}

struct ContentView: View {
  @State private var selectedTableIndex = 2
  @State private var numberOfQuestions = 5
  
  @State private var practiceMode = false
  @FocusState private var typing: Bool
  
  @State private var questions: [QuestionAndAnswer] = []
  @State private var currentQuestion = 0
  @State private var currentAnswer: Int?
  @State private var score = 0
  
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var alertIsPresented: Bool = false
  
  var body: some View {
    NavigationStack {
      if !practiceMode {
        Form {
          Section {
            Picker("Practice table of", selection: $selectedTableIndex) {
              ForEach(2 ..< 11) {
                Text("\($0)")
              }
            }
            Stepper("^[\(numberOfQuestions) question](inflect:true)", value: $numberOfQuestions, in: 5 ... 20, step: 5)
          }
        
          Section {
            HStack {
              Button("Start practice") {
                startPractice()
              }
            }.frame(minWidth: 120, maxWidth: .infinity)
          }
        }.navigationTitle("Multiplio")
        
      } else {
        VStack {
          Text(questions[currentQuestion].question)
            .font(.largeTitle)
          TextField(
            "",
            value: $currentAnswer,
            format: .number
          )
          .keyboardType(.decimalPad)
          .multilineTextAlignment(.center)
          .focused($typing)
          .onSubmit {
            nextQuestion()
          }
          .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
              Button("Stop practice") {
                stopPractice()
              }
              Spacer()
              Button("Next question") {
                nextQuestion()
              }
            }
          }
        }
        
        .alert(alertTitle, isPresented: $alertIsPresented) {
          Button("Play again") {
            stopPractice()
          }
        } message: {
          Text(alertMessage)
        }
      }
    }
  }
  
  func startPractice() {
    generateQuestions()
    withAnimation {
      practiceMode = true
      typing = true
    }
  }
  
  func stopPractice() {
    withAnimation {
      practiceMode = false
      typing = false
    }
    
    // resetting needs to happen after switching views, otherwise index is out of bounds
    currentQuestion = 0
    score = 0
    questions.removeAll()
  }
  
  func nextQuestion() {
    evaluateAnswer()
    if currentQuestion < questions.count - 1 {
      currentQuestion += 1
    } else {
      showScore()
    }
    clearInput()
    typing = true
  }
  
  func generateQuestions() {
    //picker starts at two, so it's 0'th element is actually the number 2
    let actualTable = selectedTableIndex + 2
    questions = (0 ..< numberOfQuestions).map { _ in
      let multiplier = Int.random(in: 1 ... 10)
      return QuestionAndAnswer(
        question: "\(actualTable) × \(multiplier) = ?",
        answer: actualTable * multiplier
      )
    }
  }

  func evaluateAnswer() {
    if currentAnswer == questions[currentQuestion].answer {
      score += 1
    }
  }
  
  func clearInput() {
    currentAnswer = nil
  }
  
  func showScore() {
    alertTitle = "You scored \(score) out of \(numberOfQuestions)"
    alertMessage = "Press 'Play again' to start a new game."
    alertIsPresented = true
  }
}

#Preview {
  ContentView()
}
