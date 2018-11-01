//
//  PersistentManager.swift
//  ShoppingApp
//
//  Created by Rahul on 07/10/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import Foundation
import UIKit

final class PersistentManager {
    private var products = [Product]()
    
    private var cache: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    init() {
        let product1 = Product(title: "T-shirt",
                               description: "Men's v-neck blue t-shirt",
                               price: 1200,
                               imageURL: "https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png")
        //products = [product1, product2, product3]
    }
    
    func getProducts() -> [Product] {
        return products
    }
    
    func addProduct(_ product: Product, at index: Int) -> Void {
        if products.count >= index {
            products.insert(product, at: index)
        } else {
            products.append(product)
        }
    }
    
    func deleteProduct(at index: Int) {
        products.remove(at: index)
    }
    
    func saveImage(_ image: UIImage, filename: String) {
        let url = cache.appendingPathComponent(filename)
        guard let data = UIImagePNGRepresentation(image) else {
            return
        }
        try? data.write(to: url)
    }
    
    func getImage(with filename: String) -> UIImage? {
        let url = cache.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
}
