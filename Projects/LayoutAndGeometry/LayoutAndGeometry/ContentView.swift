//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Sebastian Stoelen on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(.profileDark)
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Sebastian Stoelen")
            }

            VStack {
                Text("Full name:")
                Text("Sebastian Stoelen")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
                Text("TEST")
            }
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

#Preview {
    ContentView()
}
