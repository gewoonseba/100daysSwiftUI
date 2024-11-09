//
//  ContentView.swift
//  Instafilter
//
//  Created by Sebastian Stoelen on 07/11/2024.
//

import StoreKit
import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
