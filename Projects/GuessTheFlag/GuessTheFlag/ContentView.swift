//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sebastian Stoelen on 21/09/2024.
//

import SwiftUI

struct ContentView: View {
  fileprivate func delete() {
    print("Now deleting")
  }

  @State private var showingAlert = false

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .foregroundStyle(.blue)
      Text("Hello, World!")
    }
  }
}

#Preview {
  ContentView()
}
