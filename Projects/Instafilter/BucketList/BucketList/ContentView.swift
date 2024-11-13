//
//  ContentView.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 13/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Read and Write") {
            FileManager.write(content: "Test Message", filename: "test.txt")
            print(FileManager.read(filename: "test.txt"))
        }
    }
}

extension FileManager {
    static func read(filename: String) -> String {
        let url = URL.documentsDirectory.appending(path: filename)
    
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    static func write(content: String, filename: String) {
        let url = URL.documentsDirectory.appending(path: filename)
        
        let data = Data(content.utf8)
        
        do {
            try data.write(to: url, options: [.completeFileProtection, .atomic])
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
