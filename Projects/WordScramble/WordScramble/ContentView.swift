//
//  ContentView.swift
//  WordScramble
//
//  Created by Sebastian Stoelen on 02/10/2024.
//

import SwiftUI

struct ContentView: View {
  let people = ["Finn", "Leia", "Luke", "Rey"]

  var body: some View {
    List(people, id: \.self) {
      Text($0)
    } 
  }
}

#Preview {
  ContentView()
}
