//
//  DicerApp.swift
//  Dicer
//
//  Created by Sebastian Stoelen on 21/12/2024.
//

import SwiftData
import SwiftUI

@main
struct DicerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: DiceRoll.self)
        }
    }
}
