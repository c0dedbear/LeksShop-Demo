//
//  TabsDataManager.swift
//  LeksShop
//
//  Created by Михаил Медведев on 13/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class OrderDataManager {
    
    static let shared = OrderDataManager()
    static let orderUpdatedNotification = Notification.Name(rawValue: "OrderDataManager.orderUpdated")
    
    private init() {}
    
    var order = Order() {
        didSet {
            if !order.wheels.isEmpty {
            NotificationCenter.default.post(name: OrderDataManager.orderUpdatedNotification, object: nil)
            }
        }
    }
    
    func calculateTotalCost() -> Int {
        var totalCost = 0
        for (item, count) in order.summary {
            if let price = item.price {
            totalCost += price * count
            }
        }
        return totalCost
    }
    
}
