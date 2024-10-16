//
//  ContentView.swift
//  Navigation
//
//  Created by Sebastian Stoelen on 16/10/2024.
//

import SwiftUI

struct DetailView: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }

    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 100) { i in
                NavigationLink("Select \(i)", value: i)
                NavigationLink("String \(i)", value: "abc-\(i)")
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("Navigated to string \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}
