//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Sebastian Stoelen on 02/11/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    @State private var path = [User]()

    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    Button("Add Samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)
                        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let job1 = Job(name: "Organize sock drawer", priority: 3)
                            let job2 = Job(name: "Make plans with Alex", priority: 4)
                        first.jobs.append(contentsOf: [job1, job2])
                        
                        let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }

                    Menu("Sort", systemImage: "line.3.horizontal.decrease.circle") {
                        Button(showingUpcomingOnly ? "Show everyone" : "Show Upcoming") {
                            showingUpcomingOnly.toggle()
                        }
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate),
                                ])

                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name),
                                ])
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
