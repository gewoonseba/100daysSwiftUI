//
//  CardView.swift
//  Flashzilla
//
//  Created by Sebastian Stoelen on 12/12/2024.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled



    let card: Card
    var handleCorrect: (() -> Void)? = nil
    var handleIncorrect: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero {
        didSet {
            print("Offset changed to: \(offset)")
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(accessibilityDifferentiateWithoutColor ? .white : .white.opacity(1 - Double(abs(offset.width / 160))))
                .background(
                    accessibilityDifferentiateWithoutColor ? nil :
                    RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 4)

            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(offset)
        .opacity(2 - Double(abs(offset.width / 160)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { _ in
                    if offset.width > 160 {
                        //Moving to the right == correct
                        handleCorrect?()
                    } else if offset.width < -160 {
                        //Moving to the left == incorrect
                        handleIncorrect?()
                    }
                    else {
                        withAnimation(.spring(duration: 0.15, bounce: 0.5)) {
                            offset = .zero
                        }
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

#Preview {
    func correct() {
        print("correct")
    }
    func incorrect() {
        print("incorrect")
    }
    return CardView(card: Card.example,
             handleCorrect: correct,
             handleIncorrect: incorrect)
}
