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
import Alamofire_Synchronous

class Product: NSObject{
    var name: String = "Oreo's"
    var priceInDollars: Double = 10
    var barcodeNumber: String
    var images = [String?]()
    var productDescription: String?
    var quantity:Int
    let dateCreated:Date
    
    
    init(serialNumber: String) {
        self.barcodeNumber = serialNumber
        self.quantity = 1
        self.dateCreated = Date()
        let response = Alamofire.request("http://acropay.io/products/\(serialNumber)").validate()
            .responseJSON()
        if let data = response.result.value{
            let json = JSON(data)
            self.name = (json["name"].string!)
            self.priceInDollars = round(100*(json["price"].double!))/100
            self.images = json["images"].arrayValue.map { $0.string!}
            self.productDescription = json["description"].string!
        }
        super.init()
    }
    
    
    func stringDescription() -> String{
        return "Name: \(name), price \(priceInDollars)"
    }
    
}
