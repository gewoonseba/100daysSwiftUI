//
//  ContentView.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    UserListView(user: user)
                }
            }
            .navigationTitle("Friendface")
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

            users = try decoder.decode([User].self, from: data)
        } catch {
            print("Fetching users failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
