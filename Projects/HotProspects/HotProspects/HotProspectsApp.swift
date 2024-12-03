//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Sebastian Stoelen on 28/11/2024.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
