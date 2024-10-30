//
//  ContentView.swift
//  Bookworm
//
//  Created by Sebastian Stoelen on 29/10/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var books: [Book]

    @State private var showingAddScreen = false

    var body: some View {
        NavigationStack {
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen, content: { AddBookView() })
        }
    }
}

#Preview {
    ContentView()
}
