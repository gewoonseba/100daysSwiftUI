//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Sebastian Stoelen on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { outer in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(1..<20) { num in
                        GeometryReader { inner in
                            Text("Number \(num)")
                                .font(.largeTitle)
                                .padding()
                                .background(.red)
                            //try to get card in the middle perfectly non rotated
                                .rotation3DEffect(.degrees(-(inner.frame(in: .global).center.x) - (outer.frame(in: .global).width / 2) / 8, axis: (x: 0, y: 1, z: 0))
                                .frame(width: 200, height: 200)
                        }
                        .frame(width: 200, height: 200)
                    }
                }
            }
        }
        
    }
}


#Preview {
    ContentView()
}
