//
//  FriendListApp.swift
//  FriendList
//
//  Created by Sebastian Stoelen on 26/11/2024.
//

import SwiftUI
import SwiftData

@main
struct FriendListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
