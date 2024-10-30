//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Sebastian Stoelen on 29/10/2024.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
