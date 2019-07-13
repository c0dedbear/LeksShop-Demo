//
//  AnimatedTabBarController.swift
//  LeksShop
//
//  Created by Михаил Медведев on 13/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class AnimatedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

}

extension AnimatedTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        /// Make sure below stroke is false
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
