//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sebastian Stoelen on 24/09/2024.
//

import SwiftUI

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content

  var body: some View {
    VStack {
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<columns, id: \.self) { column in
            content(row, column)
          }
        }
      }
    }
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundStyle(.white)
      .padding()
      .background(.blue)
      .clipShape(.rect(cornerRadius: 10))
  }
}

struct WaterMark: ViewModifier {
  var text: String
  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content

      Text(text)
        .font(.caption)
        .foregroundStyle(.gray)
        .padding(5)
        .background(.thinMaterial)
    }
  }
}

extension View {
  func titleStyle() -> some View {
    modifier(Title())
  }

  func waterMarked(text: String) -> some View {
    modifier(WaterMark(text: text))
  }
}

struct ContentView: View {
  var body: some View {
    GridStack(rows: 4, columns: 4) { row, col in
      Text("R\(row) C\(col)")
    }
  }
}

#Preview {
  ContentView()
}
