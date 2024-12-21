//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Sebastian Stoelen on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0 ..< 50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: getHue(proxy.frame(in: .global), viewHeight: fullView.size.height), saturation: 0.7, brightness: 0.9))
                            .rotation3DEffect(getRotation(proxy.frame(in: .global), viewHeight: fullView.size.height), axis: (x: 0, y: 1, z: 0))
                            .opacity(getOpacity(proxy.frame(in: .global)))
                            .scaleEffect(getScale(proxy.frame(in: .global), viewHeight: fullView.size.height))
                    }
                    .frame(height: 40)
                }
            }
        }
    }

    func getRotation(_ frame: CGRect, viewHeight: CGFloat) -> Angle {
        return .degrees((frame.minY - viewHeight / 2) / 5)
    }

    func getOpacity(_ frame: CGRect) -> Double {
        if frame.minY > 200 {
            return 1
        } else {
            return frame.minY / Double(200)
        }
    }

    func getScale(_ frame: CGRect, viewHeight: CGFloat) -> CGFloat {
        let minScale: CGFloat = 0.5
        let maxScale: CGFloat = 1.5
        let percentage = frame.midY / viewHeight
        return minScale + (maxScale - minScale) * percentage
    }

    func getHue(_ frame: CGRect, viewHeight: CGFloat) -> Double {
        let minHue: CGFloat = 0
        let maxHue: CGFloat = 1
        let percentage = frame.midY / viewHeight
        return minHue + (maxHue - minHue) * percentage
    }
}

#Preview {
    ContentView()
}
