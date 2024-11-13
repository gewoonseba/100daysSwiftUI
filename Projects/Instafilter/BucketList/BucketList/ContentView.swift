//
//  ContentView.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 13/11/2024.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
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
