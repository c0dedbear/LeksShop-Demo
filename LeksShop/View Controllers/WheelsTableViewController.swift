//
//  WheelsTableViewController.swift
//  LeksShop
//
//  Created by Михаил Медведев on 11/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class WheelsTableViewController: UITableViewController {
    
    //MARK: - Properties
    var wheels = [Wheel]()
    let cellManager = CellManager()
    let networkManager = NetworkManager()


    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
}


// MARK: - Table view data source
extension WheelsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if wheels.count > 0 {
            tableView.restore()
            return wheels.count
        } else {
            tableView.setEmptyView(title: "Ошибка при загрузке каталога", message: "Пожалуйста попробуйте позже", animation: true)
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WheelCell", for: indexPath)
        let wheelItem = wheels[indexPath.row]
        cellManager.configure(cell, in: tableView, using: wheelItem)
        return cell
    }
}

// MARK: - UpdateUI
extension WheelsTableViewController {
    
    func updateUI() {
        networkManager.fetchCatalog { catalog in
            guard let catalog = catalog else { return }
            OperationQueue.main.addOperation {
                self.wheels = catalog.wheels
                self.tableView.reloadSections([0], with: .fade)
            }
        }
    }
    
}

// MARK: - Navigation
extension WheelsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailWheelsSegue" else { return }
        let destinationVC = segue.destination as! DetailWheelViewController
        let currentCellIndexPath = tableView.indexPathForSelectedRow!
        destinationVC.wheelItem = wheels[currentCellIndexPath.row]
    }
    
}
