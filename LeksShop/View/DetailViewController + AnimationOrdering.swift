//
//  DetailViewController + AnimationOrdering.swift
//  LeksShop
//
//  Created by Михаил Медведев on 14/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

// MARK: - Animate Ordering
extension DetailWheelViewController {
    func animateOrdering() {
        UIView.animate(withDuration: 0.25, animations: { [unowned self] in
            self.addToOrderButton.isEnabled = false
            self.imageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2) }, completion: { (completion) in
                if completion {
                    UIView.animate(withDuration: 0.75, animations: {
                        self.imageView.center = CGPoint(x: self.view.bounds.maxX, y: self.view.bounds.maxY) }, completion: { (isComplete) in
                            if isComplete {
                                self.imageView.transform = CGAffineTransform.identity
                                self.imageView.center = self.imageViewOriginCenter
                                UIView.animate(withDuration: 0.5, delay: 1, options: .beginFromCurrentState, animations: {
                                    self.addToOrderButton.isEnabled = true
                                }, completion: { completion in
                                    if completion {
                                        self.navigationController?.popToRootViewController(animated: true)
                                    }
                                })
                            }
                    })
                }
        })
    }
}
