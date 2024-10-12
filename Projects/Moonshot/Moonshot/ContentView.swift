//
//  ContentView.swift
//  Moonshot
//
//  Created by Sebastian Stoelen on 12/10/2024.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    var body: some View {
        let layout = [
            GridItem(.adaptive(minimum: 80)),
            ]
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0 ..< 1000) {
                    Text("Item \($0)")
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
