//
//  ProductCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Rahul on 07/10/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func initProduct(_ product: Product) {
        titleLabel.text = product.title
        priceLabel.text = String (product.price)
        self.activityIndicatorView.startAnimating()
        NotificationCenter.default.post(name: .SHDownloadImage, object: self, userInfo: ["imageView": productImageView, "imageURL": product.imageURL, "loadingSpinner": activityIndicatorView])
    }
    
}
