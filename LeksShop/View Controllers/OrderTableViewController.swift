//
//  OrderTableViewController.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    //MARK: - Properties
    let cellManager = CellManager()
    let networkManager = NetworkManager()
    
    //MARK: - Outlets
    @IBOutlet weak var sumLabel: UILabel!
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ваш заказ"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewAppearingUIUpdates()
    }
    
    //MARK: - Methods
    func updateSumLabel() {
        for index in 0..<OrderDataManager.shared.order.wheels.count {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? OrderTableViewCell {
                let item = OrderDataManager.shared.order.wheels[index]
                OrderDataManager.shared.order.summary[item] = Int(cell.stepper.value)
                sumLabel.text = "Сумма вашего заказа: \(OrderDataManager.shared.calculateTotalCost()) руб."
            }
        }
        
    }
    
    func updateSumLabelAfterRemoving(at indexPath: IndexPath) {
        for _ in 0..<OrderDataManager.shared.order.wheels.count {
            let item = OrderDataManager.shared.order.wheels[indexPath.row]
            OrderDataManager.shared.order.summary[item] = nil
            sumLabel.text = "Сумма вашего заказа: \(OrderDataManager.shared.calculateTotalCost()) руб."
        }
        
    }
    
    func viewAppearingUIUpdates() {
        tableView.reloadSections([0], with: .fade)
        updateSumLabel()
        tableView.setEditing(false, animated: true)
        navigationItem.leftBarButtonItem!.title = "Изменить"
        if tableView.visibleCells.isEmpty {
            sumLabel.text = ""
        }
    }
    
    //MARK: - IBActions
    @IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
        OrderDataManager.shared.order.id += 1
        networkManager.submitOrder(forArts: OrderDataManager.shared.order) { message in
            if let message = message {
                OperationQueue.main.addOperation {
                    let alertController = UIAlertController(title: "Заказ отправлен", message: message == "{\n  \"id\": 1\n}" ? "Спасибо за ваш заказ. Скоро с вами свяжется наш менеджер!" : message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
                        guard let firstTabVC = self.tabBarController?.viewControllers?[0] else { return }
                        OrderDataManager.shared.order = Order()
                        self.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = nil
                        self.tabBarController?.selectedViewController = firstTabVC
                        self.sumLabel.text = ""
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if !tableView.isEditing {
            tableView.setEditing(true, animated: true)
            sender.title = "Готово"
            sender.style = .done
        } else {
            tableView.setEditing(false, animated: true)
            sender.title = "Изменить"
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //define indexPath using sender position
        let stepperPosition = sender.convert(sender.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: stepperPosition) {
            let cell = tableView.cellForRow(at: indexPath) as! OrderTableViewCell
            let wheelItem = OrderDataManager.shared.order.wheels[indexPath.row]
            OrderDataManager.shared.order.summary.updateValue(Int(sender.value), forKey: wheelItem)
            cell.quantityLabel.text = "\(OrderDataManager.shared.order.summary[wheelItem] ?? 1) шт."
            sumLabel.text = "Сумма вашего заказа: \(OrderDataManager.shared.calculateTotalCost()) руб."
        }
    }
}

// MARK: - Table view data source
extension OrderTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if OrderDataManager.shared.order.wheels.count == 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.isEnabled = false
            tableView.setEmptyView(title: "Вы пока ничего не добавили", message: "Ваша корзина пуста", animation: false)
            return 0
        } else {
            tableView.restore()
            navigationItem.leftBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.isEnabled = true
            return OrderDataManager.shared.order.wheels.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
        let wheelItem = OrderDataManager.shared.order.wheels[indexPath.row]
        cellManager.configure(cell, in: self, using: wheelItem)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            updateSumLabelAfterRemoving(at: indexPath)
            OrderDataManager.shared.order.wheels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(#line, #function, OrderDataManager.shared.calculateTotalCost())
            if OrderDataManager.shared.order.wheels.count < 1 {
                tabBarController?.viewControllers?[2].tabBarItem.badgeValue = nil
                sumLabel.text = ""
            }
        }
    }
    
}
