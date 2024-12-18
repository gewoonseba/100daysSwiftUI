//
//  ContentView.swift
//  WordScramble
//
//  Created by Sebastian Stoelen on 02/10/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var rootWord = ""
  @State private var newWord = ""
  @State private var usedWords = [String]()

  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false

  @State private var score = 0

  var body: some View {
    NavigationStack {
      List {
        Section {
          TextField("Enter a new word", text: $newWord)
            .textInputAutocapitalization(.never)
            .onSubmit(addNewWord)
        }
        Section {
          VStack {
            Text("Score")
            Text("\(score)")
              .font(.largeTitle)
          }
          .frame(maxWidth: .infinity, alignment: .center)
        }

        Section {
          ForEach(usedWords, id: \.self) { word in
            HStack {
              Image(systemName: "\(word.count).circle")
              Text(word)
            }
            .accessibilityElement()
            .accessibilityLabel("\(word),  \(word.count) letters")
          }
        }
      }
      .navigationTitle(rootWord)
      .toolbar(content: {
        ToolbarItem(placement: .primaryAction) {
          Button("New Game") {
            startGame()
            withAnimation {
              usedWords.removeAll()
              score = 0
            }
          }
        }
      })
      .onAppear(perform: startGame)
      .alert(errorTitle, isPresented: $showingError) {} message: {
        Text(errorMessage)
      }
    }
  }

  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

    guard answer.count > 0 else { return }

    guard isOriginal(answer) else {
      wordError(title: "Word already used", message: "Be more original.")
      return
    }

    guard isPossilbe(answer) else {
      wordError(title: "Word not possible", message: "You can't spell that from \(rootWord).")
      return
    }

    guard isReal(answer) else {
      wordError(title: "Word not real", message: "That's not a real word.")
      return
    }

    guard isLongEnough(answer) else {
      wordError(title: "Word not long enough", message: "Try more than 3 letters.")
      return
    }

    guard isNotStartingWord(answer) else {
      wordError(title: "Word equal to starting word", message: "That's just the starting word!")
      return
    }

    updateScore(answer)
    withAnimation {
      usedWords.insert(answer, at: 0)
    }
    newWord = ""
  }

  func startGame() {
    // find the txt file in the bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      // read the contents of the file
      if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
        // split the contents by newlines
        let allWords = startWords.components(separatedBy: .newlines)
        rootWord = allWords.randomElement() ?? "silkworm"
        return
      }
    }
    fatalError("Could not load start.txt from bundle.")
  }

  func isOriginal(_ word: String) -> Bool {
    !usedWords.contains(word)
  }

  func isPossilbe(_ word: String) -> Bool {
    var rootCopy = rootWord

    for letter in word {
      if let pos = rootCopy.firstIndex(of: letter) {
        rootCopy.remove(at: pos)
      } else {
        return false
      }
    }
    return true
  }

  func isReal(_ word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
  }

  func isLongEnough(_ word: String) -> Bool {
    return word.count >= 3
  }

  func isNotStartingWord(_ word: String) -> Bool {
    return word != rootWord
  }

  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }

  func updateScore(_ word: String) {
    score += word.count
  }
}

#Preview {
  ContentView()
}
