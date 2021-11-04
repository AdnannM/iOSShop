//
//  ShopTableViewController.swift
//  iOSShop
//
//  Created by Adnann Muratovic on 03.11.21.
//

import UIKit

class ShopTableViewController: UITableViewController {

    var shop = [Shop]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 500.0
        tableView.rowHeight = UITableView.automaticDimension
        fetchData()
    }
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
        
        cell?.modelLabel!.text = shop.model
        cell?.nameLabel!.text = shop.name
        cell?.priceLabel!.text = String("\(shop.price)$")
        
        return cell!
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
