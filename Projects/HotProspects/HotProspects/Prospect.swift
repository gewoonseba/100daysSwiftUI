//
//  Prospect.swift
//  HotProspects
//
//  Created by Sebastian Stoelen on 03/12/2024.
//

import SwiftData
import Foundation

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var createdAt: Date
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.createdAt = Date()
    }
}
