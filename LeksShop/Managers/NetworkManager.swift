//
//  SearchResultsNetworkManager.swift
//  Itunes Samples
//
//  Created by Михаил Медведев on 03/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class NetworkManager {
    
    //MARK: - Properties
    let baseURL = URL(string: "https://my-json-server.typicode.com/smokeMMA/screenshots")!

    //MARK: - Methods
    func fetchCatalog(completion: @escaping (Catalog?) -> Void ) {
        let catalogURL = baseURL.appendingPathComponent("db")
        
        URLSession.shared.dataTask(with: catalogURL) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return }
            
            let decoder = JSONDecoder()
            let catalog = try? decoder.decode(Catalog.self, from: data)
            completion(catalog)
            
        }.resume()
    }
    
    func fetchImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = url else {
            print("Invalid URL of Image")
            completion(nil)
            return }
        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    // (this test server is not responding for POST requests, it is always return only json with id number)
    func submitOrder(forArts arts: Order, completion: @escaping (String?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        let jsnoEncoder = JSONEncoder()
        let jsonData = try? jsnoEncoder.encode(OrderDataManager.shared.order.id)
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _ , error) in
            guard let data = data else {
                completion(error?.localizedDescription)
                return
            }
            
            let message = String(data: data, encoding: .utf8)
            
            completion(message)
            print("Ответ сервера:", message ?? "")
            
        }.resume()
        
    }
}
