//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Sebastian Stoelen on 23/12/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}


struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    var body: some View {
        NavigationSplitView {
            List(resorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                HStack {
                    ResortDetailsView(resort: resort)
                    SkiDetailsView(resort: resort)
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                ResortView(resort: resort)
            }
        } detail: {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
