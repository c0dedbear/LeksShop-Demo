//
//  Wheels.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import Foundation

// MARK: - Wheel
struct Wheel: Codable, Hashable {
    let art, brand, model: String?
    let imageUrl: URL?
    let price: Int?
    let currency, description: String?
    
    init(art: String? = nil,
         brand: String? = nil,
         model: String? = nil,
         imageUrl: URL? = nil,
         price: Int? = nil,
         currency: String? = nil,
         description: String? = nil)
    {
        self.art = art
        self.brand = brand
        self.model = model
        self.imageUrl = imageUrl
        self.price = price
        self.currency = currency
        self.description = description
    }
}
