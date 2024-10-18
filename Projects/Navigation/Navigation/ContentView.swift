//
//  ContentView.swift
//  Navigation
//
//  Created by Sebastian Stoelen on 16/10/2024.
//

import SwiftUI

struct DetailView: View {
    var number: Int
    
    @Binding var path: [Int]

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1 ... 1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i,path: $pathStore.path)
                }
        }
    }
}

#Preview {
    ContentView()
}
