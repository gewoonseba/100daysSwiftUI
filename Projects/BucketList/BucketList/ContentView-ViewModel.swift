//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 20/11/2024.
//

import CoreLocation
import Foundation
import LocalAuthentication

@Observable
class ViewModel {}

extension ContentView {
    @Observable
    class ViewModel {
        var isUnlocked = false
        
        private(set) var locations: [Location]
        var selectedPlace: Location?

        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func addLocation(at coordinate: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
            locations.append(newLocation)
            save()
        }

        func updateSelectedLocation(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
    }
}
