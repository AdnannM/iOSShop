//
//  ShopListViewModel.swift
//  iOSShop
//
//  Created by Adnann Muratovic on 10.11.21.
//

import Foundation

class ShopListViewModel {
     static let shared = ShopListViewModel()
    var shop = [Shop]()
    
    func fetchShopItem() async throws {
        let urlString = Constants.baseURL + Endpoints.endpoint
        guard let url  = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let shopResponse: [Shop] = try await HttpClient.shared.fetch(url: url)
        DispatchQueue.main.async {
            self.shop = shopResponse
        }
    }
}
