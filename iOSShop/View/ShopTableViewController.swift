//
//  ShopTableViewController.swift
//  iOSShop
//
//  Created by Adnann Muratovic on 03.11.21.
//

import UIKit
import ViewAnimator

class ShopTableViewController: UITableViewController {
    // MARK: - Properties
    var shop = [Shop]()
    let cellHight: CGFloat = 500
    // View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome to Store"
        tableView.estimatedRowHeight = 500.0
        tableView.rowHeight = UITableView.automaticDimension
        Task {
                try await ShopListViewModel.shared.fetchShopItem()
                self.tableView.reloadData()
        }
        // fetchShopItem()
        animateCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateCell()
    }
    // MARK: - Animation
    private func animateCell() {
        let animations = AnimationType.random()
        UIView.animate(views: tableView.subviews.self, animations: [animations])
    }
    // MARK: - Parse JSON
//    func fetchShopItem() {
//        let url = URL(string: "http://localhost:8080/store")!
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "Unknow Error")
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                let shopItem = try decoder.decode([Shop].self, from: data)
//                DispatchQueue.main.async {
//                    self.shop = shopItem
//                    self.tableView.reloadData()
//                    print("Loaded \(self.shop.count) shop Item")
//                }
//            } catch {
//                print("Unable to parse JSON Response")
//            }
//        }.resume()
//    }
}
// MARK: - Table view data source
extension ShopTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
        } else if indexPath.row == 1 {
            cell?.imageViewCell.image = UIImage(named: "macbook-18")
        } else if indexPath.row == 2 {
            cell?.imageViewCell.image = UIImage(named: "macbook-16")
        } else if indexPath.row == 3 {
            cell?.imageViewCell.image = UIImage(named: "macbook-3")
        }
        cell?.modelLabel!.text = shop.model
        cell?.nameLabel!.text = shop.name
        cell?.cpuLabel.text = shop.cpu
        cell?.priceLabel!.text = String("\(shop.price)$")
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHight
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let macShop = shop[indexPath.row]
        let alert = UIAlertController(title: "Order a \(macShop.name)\n\(macShop.price)$",
                                      message: "Please Enter your name!",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Order it!", style: .default, handler: { _ in
            guard let name = alert.textFields?[0].text else { return }
            let messageOrder = UIAlertController(title: "Order Successful!", message: "You successfully order new\n\(macShop.name)!", preferredStyle: .alert)
            messageOrder.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(messageOrder, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //    private func order(_ shop: Shop, name: String) {
    //        let order = Order(itemName: shop.name, buyerName: name)
    //        let url = URL(string: "http://localhost:8080/order")!
    //        let encoder = JSONEncoder()
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.httpBody = try? encoder.encode(order)
    //        URLSession.shared.dataTask(with: request) { data, _, error in
    //            if let data = data {
    //                let decoder = JSONDecoder()
    //                do {
    //                    let item = try decoder.decode(Order.self, from: data)
    //                    print(item.buyerName)
    //                } catch {
    //                    print(error.localizedDescription)
    //                }
    //            }
    //        }.resume()
    //    }
}
