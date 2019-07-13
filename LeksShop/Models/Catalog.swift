//
//  Catalog.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//


// MARK: - Catalog
struct Catalog: Codable {
    let wheels: [Wheel]
    let vehicles: [Vehicle]
}
