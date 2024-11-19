//
//  ContentView.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 13/11/2024.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .onTapGesture {
                                print("tap")
                                selectedPlace = location
                            }
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    addToLocations(coordinate: coordinate)
                }
            }
            .sheet(item: $selectedPlace) { place in
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            }
        }
    }

    func addToLocations(coordinate: CLLocationCoordinate2D) {
        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
        locations.append(newLocation)
    }
}

#Preview {
    ContentView()
}
