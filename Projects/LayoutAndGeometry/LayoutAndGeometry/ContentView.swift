//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Sebastian Stoelen on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in 5}
            }
            Text("Real leading")
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
