//
//  LibAPI.swift
//  ShoppingApp
//
//  Created by Rahul on 07/10/18.
//  Copyright © 2018 Rahul. All rights reserved.
//
//Facade Pattern
import Foundation
import UIKit

final class LibAPI {
    private let persistentManager = PersistentManager()
    private let httpClient = HttpService()
    //private let isOnline = false
    let url = "https://jsonplaceholder.typicode.com/photos"
    
    static let shared = LibAPI()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(with:)), name: .SHDownloadImage, object: nil)
    }
    
    func getProducts(withCompletion completion: @escaping ([Product]?) -> Void ) {
        var products = [Product]()
        self.httpClient.getRequest(url) { (DataArr) in
            if let list = DataArr {
                for item in list {
                    let itemDict = item as! [AnyHashable: Any]
                    let product = Product(title: itemDict["title"] as! String, description: itemDict["title"] as! String, price: (itemDict["id"] as! Int) * 1000, imageURL: itemDict["url"] as! String)
                    
                    products.append(product)
                }
                completion(products)
            } else {
                completion(nil)
            }
        }
        //return persistentManager.getProducts()
    }
    
    @objc func downloadImage(with notification: Notification) {
        guard let userInfo = notification.userInfo,
            let imageView = userInfo["imageView"] as? UIImageView,
            let imageURL = userInfo["imageURL"] as? String,
            let indicatorView = userInfo["loadingSpinner"] as? UIActivityIndicatorView,
            let filename = URL(string: imageURL)?.lastPathComponent else {
            return
        }
        if let savedImage = persistentManager.getImage(with: filename) {
            imageView.image = savedImage
            indicatorView.stopAnimating()
            return
        }
        
        DispatchQueue.global().async {
            let downloadedImage = self.httpClient.downloadImage(imageURL) ?? UIImage()
            DispatchQueue.main.async {
                imageView.image = downloadedImage
                indicatorView.stopAnimating()
                self.persistentManager.saveImage(downloadedImage, filename: filename)
            }
        }
        
    }
    
}
