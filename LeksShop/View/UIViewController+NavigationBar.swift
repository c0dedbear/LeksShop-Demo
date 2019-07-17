//
//  NavigationBar.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

// MARK: - Add Navigation Bar Image Title
extension UIViewController {
    
    func addNavBarImage() {
        let image = UIImage(named: "lekslogo")!
        let imageView = UIImageView(image: image)
        
        if let navController = navigationController {
            navController.navigationBar.tintColor = .white
            let bannerWidth = navController.navigationBar.frame.size.width
            let bannerHeight = navController.navigationBar.frame.size.height
            
            let bannerX = bannerWidth / 2 - image.size.width / 2
            let bannerY = bannerHeight / 2 - image.size.height / 2
            
            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit
            navigationItem.titleView = imageView
        }
    }
}
