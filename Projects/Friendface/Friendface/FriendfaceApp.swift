//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Sebastian Stoelen on 05/11/2024.
//

import SwiftData
import SwiftUI

@main
struct FriendfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
