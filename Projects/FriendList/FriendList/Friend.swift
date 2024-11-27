//
//  Friend.swift
//  FriendList
//
//  Created by Sebastian Stoelen on 26/11/2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Friend {
    
    var name: String
    @Attribute(.externalStorage) var photo: Data
    private var latitude: Double?
    private var longitude: Double?
    

    init(name: String, photo: Data, coordinate: CLLocationCoordinate2D?) {
        self.name = name
        self.photo = photo
        self.coordinate = coordinate
    }

    var coordinate: CLLocationCoordinate2D? {
        get {
            guard let latitude = latitude, let longitude = longitude else { return nil }
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue?.latitude
            longitude = newValue?.longitude
        }
    }
}
