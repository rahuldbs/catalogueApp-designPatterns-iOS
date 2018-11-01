//
//  Product.swift
//  ShoppingApp
//
//  Created by Rahul on 06/10/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import Foundation

typealias ProductData = (title: String, value: String)

struct Product {
    let title: String
    let description: String
    let price: Int
    let imageURL: String
}

extension Product {
    var collectionRepresentation: [ProductData] {
        return [
            ("Product", title),
            ("Description", description)
        ]
    }
}
