//
//  ContentView.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 13/11/2024.
//

import MapKit
import SwiftUI

// Add this enum outside of your ContentView struct
enum MapStyleOption: String, CaseIterable {
    case standard = "Standard"
    case hybrid = "Hybrid"
    case satellite = "Satellite"
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .satellite:
            return .imagery
        }
    }
}

struct ContentView: View {
    @State private var viewModel = ViewModel()

    @State private var mapStyle: MapStyleOption = .standard

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onTapGesture {
                                        print("tap")
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle.mapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.updateSelectedLocation(location: $0)
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        Picker("Map Style", selection: $mapStyle) {
                            Text("Standard").tag(MapStyleOption.standard)
                            Text("Hybrid").tag(MapStyleOption.hybrid)
                            Text("Satellite").tag(MapStyleOption.satellite)
                        }
                        .pickerStyle(.segmented)
                        .padding(10)
                        .frame(maxWidth: 300)
                        .background(.thinMaterial)
                        .clipShape(.rect(cornerRadius: 14))
                        .padding(.horizontal)
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Error authenticating", isPresented: $viewModel.errorUnlocking) {
                    Button("OK") {}
                } message: {
                    Text(viewModel.errorMessage)
                }
        }
    }
}

#Preview {
    ContentView()
}
