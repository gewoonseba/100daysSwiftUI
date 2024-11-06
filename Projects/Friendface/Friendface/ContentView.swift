//
//  ContentView.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        UserRowView(user: user)
                    }
                }
            }
            .navigationTitle("Friendface")
            .navigationDestination(for: User.self, destination: { user in
                UserDetailView(user: user)
            })
            .task {
                await fetchUsers()
            }
        }
    }

    func fetchUsers() async {
        guard users.isEmpty else { return }
        
        print("Fetching users...")
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let decodedUsers = try decoder.decode([User].self, from: data)
            
            for user in decodedUsers {
                modelContext.insert(user)
            }
            
        } catch {
            print("Fetching users failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
