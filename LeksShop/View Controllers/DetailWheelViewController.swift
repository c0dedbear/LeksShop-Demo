//
//  DetailWheelViewController.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class DetailWheelViewController: UIViewController {
    
    //MARK: - Properties
    var wheelItem: Wheel!
    var imageViewOriginCenter: CGPoint!
    let networkManager = NetworkManager()
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addToOrderButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var labelForStepper: UILabel!
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewOriginCenter = imageView.center
        addNavBarImage()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.center = imageViewOriginCenter
        imageView.transform = CGAffineTransform.identity
        addToOrderButton.isEnabled = true
        imageView.setNeedsDisplay()
    }
    
    //MARK: - IBActions
    @IBAction func addToOrderButtonPressed(_ sender: UIButton) {
        if !OrderDataManager.shared.order.wheels.contains(wheelItem) {
            OrderDataManager.shared.order.wheels.append(wheelItem)
            animateOrdering()
        } else {
            animateOrdering()
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        OrderDataManager.shared.order.summary.updateValue(Int(stepper.value), forKey: wheelItem)
        labelForStepper.text = "\(Int(sender.value)) шт."
       
    }
    
    //MARK: - Methods
    func updateUI() {
        guard let wheelItem = wheelItem else { return }
        networkManager.fetchImage(from: wheelItem.imageUrl) { image in
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
        nameLabel.text = wheelItem.model
        descriptionTextView.text = wheelItem.description
        priceLabel.text = "Цена: \(wheelItem.price!) \(wheelItem.currency!)"
    }
    
    
}
