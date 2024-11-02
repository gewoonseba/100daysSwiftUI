//
//  RatingView.swift
//  Bookworm
//
//  Created by Sebastian Stoelen on 30/10/2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating: Int = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor: Color = .gray
    var onColor: Color = .yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating+1) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(color(for: number))
                }
            }
        }.buttonStyle(.plain)

    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
    
    func color(for number: Int) -> Color {
        if number > rating {
            offColor
        } else {
            onColor
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}