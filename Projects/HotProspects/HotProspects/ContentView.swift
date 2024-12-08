//
//  ContentView.swift
//  HotProspects
//
//  Created by Sebastian Stoelen on 28/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    // Create an in-memory ModelContainer
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prospect.self, configurations: config)

    // Add some sample data
    let prospect1 = Prospect(name: "John Doe", emailAddress: "john@example.com", isContacted: false)
    let prospect2 = Prospect(name: "Jane Smith", emailAddress: "jane@example.com", isContacted: true)
    container.mainContext.insert(prospect1)
    container.mainContext.insert(prospect2)
    
    return ContentView()
        .modelContainer(container)
}
