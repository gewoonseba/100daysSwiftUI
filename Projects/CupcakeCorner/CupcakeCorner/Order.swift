//
//  Order.swift
//  CupcakeCorner
//
//  Created by Sebastian Stoelen on 25/10/2024.
//

import SwiftUI

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    private static let storageKey = "savedOrder"
    
    var type: Int {
        didSet { saveOrder() }
    }
    var quantity: Int {
        didSet { saveOrder() }
    }
    var specialRequestEnabled: Bool {
        didSet {
            saveOrder()
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool {
        didSet { saveOrder() }
    }
    var addSprinkles: Bool {
        didSet { saveOrder() }
    }
    var name: String {
        didSet { saveOrder() }
    }
    var streetAddress: String {
        didSet { saveOrder() }
    }
    var city: String {
        didSet { saveOrder() }
    }
    var zip: String {
        didSet { saveOrder() }
    }

    var hasValidAddress: Bool {
        if name.isEmptyOrWhiteSpaces || streetAddress.isEmptyOrWhiteSpaces || city.isEmptyOrWhiteSpaces || zip.isEmptyOrWhiteSpaces {
            return false
        }

        return true
    }

    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    init() {
        // Initialize with default values first
        self.type = 0
        self.quantity = 3
        self.specialRequestEnabled = false
        self.extraFrosting = false
        self.addSprinkles = false
        self.name = ""
        self.streetAddress = ""
        self.city = ""
        self.zip = ""
        
        // Then load saved data if available
        if let data = UserDefaults.standard.data(forKey: Self.storageKey),
           let savedOrder = try? JSONDecoder().decode(Order.self, from: data) {
            self.type = savedOrder.type
            self.quantity = savedOrder.quantity
            self.specialRequestEnabled = savedOrder.specialRequestEnabled
            self.extraFrosting = savedOrder.extraFrosting
            self.addSprinkles = savedOrder.addSprinkles
            self.name = savedOrder.name
            self.streetAddress = savedOrder.streetAddress
            self.city = savedOrder.city
            self.zip = savedOrder.zip
        }
    }
    
    private func saveOrder() {
        guard let encoded = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(encoded, forKey: Self.storageKey)
    }
}

extension String {
    var isEmptyOrWhiteSpaces: Bool {
        if isEmpty { return true }
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
