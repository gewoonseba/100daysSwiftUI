//
//  ContentView.swift
//  Bookworm
//
//  Created by Sebastian Stoelen on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
            NavigationStack {
                Form {
                    TextEditor(text: $notes)
                                    .navigationTitle("Notes")
                                    .padding()
                }
               
            }
        }
}

#Preview {
    ContentView()
}
