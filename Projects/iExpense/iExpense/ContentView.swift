//
//  ContentView.swift
//  iExpense
//
//  Created by Sebastian Stoelen on 09/10/2024.
//

import SwiftUI

@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SecondView: View {
    let name: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Hello \(name)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Sebastian")
        }
    }
}

#Preview {
    ContentView()
}
