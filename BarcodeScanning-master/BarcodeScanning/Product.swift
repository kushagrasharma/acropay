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
    private var user = "client"
    private var password = "cs50final123"
    
    init(name: String = "Oreos", serialNumber: String = "0044000007492", valueInDollars: Double = 2.75, quantity: Int = 1) {
        let JSONData 
        self.name = name
        self.priceInDollars = round(100*valueInDollars)/100
        self.barcodeNumber = serialNumber
        self.dateCreated = Date()
        self.quantity = quantity
        
        super.init()
    }
    
    func stringDescription() -> String{
        return "Name: \(name), price \(priceInDollars)"
    }
    
    // http://stackoverflow.com/questions/24379601/how-to-make-an-http-request-basic-auth-in-swift
    func getDataFromServer(barcode: String) -> JSON?{
        Alamofire.request("http://acropay.io/products/\(barcode)")
                 .authenticate(user: self.user, password: self.password)
                 .responseJSON { response in
            if((response.result.value) != nil) {
                return JSON(responseData.result.value!)
            }
            return nil
        }
    }
}
