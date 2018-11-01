//
//  FirstViewController.swift
//  ShoppingApp
//
//  Created by Rahul on 06/10/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    private enum Constants {
        static let CellIdentifier = "productCollectionViewCell"
    }
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var productList: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         LibAPI.shared.getProducts(withCompletion: { (products) in
            if products != nil {
                self.productList = products
//                let product3 = Product(title: "Shirt",
//                                       description: "Men's v-neck blue t-shirt",
//                                       price: 2500,
//                                       imageURL: "https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png")
//                self.productList?.append(product3)
                print("last1: ", products?.last ?? [])
            } else {
                print("products not found")
            }
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        })
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //productCollectionView.reloadData()
    }
    
    // CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = productList else {
            return 0
        }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier, for: indexPath) as! ProductCollectionViewCell
        if let products = productList {
            let row = indexPath.row
            cell.initProduct(products[row])
        }
        return cell
    }
}

