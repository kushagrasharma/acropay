//
//  Item.swift
//  BarcodeScanning
//
//  Created by Faisal Younus on 12/7/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Product: NSObject{
    var name: String
    var priceInDollars: Double
    var barcodeNumber: String
    var images = [UIImage?]()
    var productDescription: String?
    var quantity:Int
    let dateCreated: Date
    
    
    init(name: String = "Oreos", serialNumber: String = "0044000007492", valueInDollars: Double = 2.75, quantity: Int = 1) {
        let user = "admin"
        let password = "secret"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        print(headers)
        var json:JSON?
        Alamofire.request("http://acropay.io/products/\(serialNumber)\(user)/\(password)", headers: headers)
            .responseJSON { response in
                if response.result.value != nil{
                    json = JSON(response.result.value!)
                    print(response.result.value!)
                }
        }
        self.barcodeNumber = serialNumber
        self.quantity = 1
        if let JSONData = json{
            self.name = JSONData["name"].string!
            self.priceInDollars = round(100*JSONData["price"].double!)/100
            self.dateCreated = Date()
            
        }
        else{
            self.name = name
            self.priceInDollars = round(100*valueInDollars)/100
            self.dateCreated = Date()
            
        }
        super.init()
    }
    
    func stringDescription() -> String{
        return "Name: \(name), price \(priceInDollars)"
    }
    
}
