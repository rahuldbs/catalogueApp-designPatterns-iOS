//
//  HttpService.swift
//  ShoppingApp
//
//  Created by Rahul on 06/10/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import UIKit

class HttpService {
    
    func getRequest(_ url: String, withCompletion completion: @escaping (Array<Any>?) -> Void) {
        let urlString = URL(string: url)
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error == nil, let resultData = data {
                    print("data received")
                    guard let jsonData = try? JSONSerialization.jsonObject(with: resultData, options: .mutableContainers) else {
                        completion(nil)
                        return
                    }
                    completion(jsonData as? Array)
                } else {
                    print("API Error: ", error!)
                    completion(nil)
                }
             })
            task.resume()
        }
        //return Data() as AnyObject
    }
    
    @discardableResult func postRequest(_ url: String, body: String) -> AnyObject {
        return Data() as AnyObject
    }
    
    func downloadImage(_ url: String) -> UIImage? {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }
    
}
