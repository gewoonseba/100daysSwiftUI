//
//  NewFriendView.swift
//  FriendList
//
//  Created by Sebastian Stoelen on 26/11/2024.
//

import Foundation
import MapKit
import SwiftData
import SwiftUI

struct NewFriendView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Binding var selectedImageData: Data?
    @State private var newFriendName = ""
    @State private var selectedLocation: CLLocationCoordinate2D?

    @State private var mapPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationStack {
            VStack {
                if let imageData = selectedImageData,
                   let uiImage = UIImage(data: imageData)
                {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .strokeBorder(.background, lineWidth: 4)
                        )
                        .shadow(radius: 10)
                }

                TextField("Friend's name", text: $newFriendName)
                    .textFieldStyle(.plain)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Where did you meet?")
                        .font(.body)
                        .foregroundStyle(.secondary)

                    MapReader { proxy in
                        Map(position: $mapPosition) {
                            if let selectedLocation {
                                Marker(newFriendName, coordinate: selectedLocation)
                            }
                        }
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                selectedLocation = coordinate
                            }
                        }
                    }
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
            .navigationTitle("New Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let imageData = selectedImageData {
                            let friend = Friend(name: newFriendName,
                                                photo: imageData,
                                                coordinate: selectedLocation)
                            modelContext.insert(friend)
                            dismiss()
                        }
                    }
                    .disabled(newFriendName.isEmpty || selectedImageData == nil)
                }
            }
            .onAppear {
                locationFetcher.start()

                Task {
                    if let location = locationFetcher.lastKnownLocation {
                        mapPosition = MapCameraPosition.region(MKCoordinateRegion(
                            center: location,
                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                        ))
                        selectedLocation = location
                    }
                }
            }
        }
    }
}

#Preview {
    guard let placeholderImage = UIImage(systemName: "person.circle.fill"),
          let imageData = placeholderImage.jpegData(compressionQuality: 0.8)
    else {
        return NewFriendView(selectedImageData: .constant(nil))
    }

    return NewFriendView(selectedImageData: .constant(imageData))
}
