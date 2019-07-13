//
//  CellManager.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 10/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class CellManager {
    
    let networkManager = NetworkManager()
    
    func configure(_ cell: UITableViewCell, in tableView: UITableView, using wheel: Wheel) {
        cell.imageView?.layer.cornerRadius = 8
        
        networkManager.fetchImage(from: wheel.imageUrl) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
        
        cell.textLabel?.text = wheel.model
        guard let price = wheel.price, let currency = wheel.currency else { return }
        cell.detailTextLabel?.text = "\(price) \(currency)"
        
        
    }
    
    func configure(_ orderCell: OrderTableViewCell, in controller: OrderTableViewController, using wheel: Wheel) {
        orderCell.imageView?.layer.cornerRadius = 8
        
       networkManager.fetchImage(from: wheel.imageUrl) { image in
            if let image = image {
                DispatchQueue.main.async {
                    orderCell.wheelImageView.image = image
                    orderCell.setNeedsLayout()
                }
            }
        }
        guard let price = wheel.price, let currency = wheel.currency else { return }
        orderCell.nameLabel?.text = wheel.model
        orderCell.priceLabel.text = "\(price) \(currency)"
        
        let count = OrderDataManager.shared.order.summary[wheel] ?? 1
        orderCell.stepper.value = Double(count)
        orderCell.quantityLabel.text = "\(count) шт."
    }
    
}
