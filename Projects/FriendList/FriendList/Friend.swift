//
//  Friend.swift
//  FriendList
//
//  Created by Sebastian Stoelen on 26/11/2024.
//

import Foundation
import SwiftData

@Model
class Friend {
    
    var name: String
    @Attribute(.externalStorage) var photo: Data

    init(name: String, photo: Data) {
        self.name = name
        self.photo = photo
    }
}
