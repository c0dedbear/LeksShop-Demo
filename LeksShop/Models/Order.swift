//
//  Order.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

struct Order: Codable {
    
    var id: Int
    var wheels: [Wheel]
    var summary: [Wheel : Int]
    
    //constructor for possibilty to create empty struct
    init(id: Int = 0, wheels: [Wheel] = [], cost: Int = 0, summary: [Wheel : Int] = [Wheel(): 0] ) {
        self.id = id
        self.wheels = wheels
        self.summary = summary
        
    }
    
}
