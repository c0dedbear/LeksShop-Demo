//
//  AppDelegate.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var orderTabBarItem: UITabBarItem!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //use cache
        URLCache.shared = URLCache(memoryCapacity: 25_000_000, diskCapacity: 50_000_000, diskPath: NSTemporaryDirectory())
        
        //setup updating Badge in Order TabBarItem
        let tabBarController = window?.rootViewController as? AnimatedTabBarController
        let orderVC = tabBarController!.viewControllers![2]
        orderTabBarItem = orderVC.tabBarItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrderBadge), name: OrderDataManager.orderUpdatedNotification, object: nil)
        
        return true
    }
    
    @objc func updateOrderBadge() {
        orderTabBarItem.badgeValue = String(OrderDataManager.shared.order.wheels.count)
    }
    
}

