//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Sebastian Stoelen on 02/11/2024.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
