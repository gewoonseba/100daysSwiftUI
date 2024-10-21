//
//  ContentView.swift
//  Moonshot
//
//  Created by Sebastian Stoelen on 12/10/2024.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission

    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

struct GridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        MissionCardView(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationDestination(for: Mission.self) { selection in
                MissionDetailView(mission: selection, astronauts: astronauts)
            }
        }
    }
}

struct ListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    HStack(alignment: .center, spacing: 16) {
                        Image(mission.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        Text(mission.displayName)
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Mission.self) { selection in
            MissionDetailView(mission: selection, astronauts: astronauts)
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var gridLayout = true

    var body: some View {
        NavigationStack {
            Group {
                if gridLayout {
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button {
                        withAnimation {
                            gridLayout.toggle()
                        }
                    } label: {
                        Group {
                            if gridLayout {
                                Image(systemName: "list.bullet")
                            } else {
                                Image(systemName: "rectangle.grid.2x2")
                            }
                        }.foregroundStyle(.white.opacity(0.5))
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
