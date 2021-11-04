//
//  ShopTableViewController.swift
//  iOSShop
//
//  Created by Adnann Muratovic on 03.11.21.
//

import UIKit

class ShopTableViewController: UITableViewController {

    // MARK: - Properties
    var shop = [Shop]()
    let cellHight: CGFloat = 500
    
    //View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 500.0
        tableView.rowHeight = UITableView.automaticDimension
        fetchData()
    }
    
    // MARK: - Parse JSON
    private func fetchData() {
        let url = URL(string: "http://localhost:8080/store")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Unknow Error")
                return
            }
            let decoder = JSONDecoder()
            do {
                let shopItem = try decoder.decode([Shop].self, from: data)
                DispatchQueue.main.async {
                    self.shop = shopItem
                    self.tableView.reloadData()
                    print("Loaded \(self.shop.count) shop Item")
                }
            }
            catch {
                print("Unable to parse JSON Response")
            }
        }.resume()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shop.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shop = shop[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShopTableViewCell
        
        // Configure cell
        if indexPath.row == 0 {
            cell?.imageViewCell.image = UIImage(named: "macbook-10")
            cell?.modelLabel!.text = shop.model
            cell?.nameLabel!.text = shop.name
            cell?.cpuLabel.text = shop.cpu
            cell?.priceLabel!.text = String("\(shop.price)$")
        } else if indexPath.row == 1 {
            cell?.imageViewCell.image = UIImage(named: "macbook-1")
            cell?.modelLabel!.text = shop.model
            cell?.nameLabel!.text = shop.name
            cell?.cpuLabel.text = shop.cpu
            cell?.priceLabel!.text = String("\(shop.price)$")
        }
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHight
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let macShop = shop[indexPath.row]
        
        let ac = UIAlertController(title: "Order a \(macShop.name)\n\(macShop.price)$",
                                   message: "Please Enter your name!",
                                   preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Order it!", style: .default, handler: { action in
            guard let name = ac.textFields?[0].text else { return }
            self.order(macShop, name: name)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func order(_ shop: Shop, name: String) {
        let order = Order(itemName: shop.name, buyerName: name)
        
        let url = URL(string: "http//localhost:8080/store")!
        
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(order)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let item = try decoder.decode(Order.self, from: data)
                    print(item.buyerName)
                }
                catch {
                    print(error.localizedDescription ?? "Error")
                }
                
            }
        }.resume()
    }
}
