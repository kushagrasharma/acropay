//
//  Item.swift
//  BarcodeScanning
//
//  Created by Faisal Younus on 12/7/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

import UIKit

class Product: NSObject{
    var name: String
    var priceInDollars: Double
    var barcodeNumber: String
    var images = [UIImage?]()
    var productDescription: String?
    var quantity:Int
    let dateCreated: Date
    
    init(name: String = "Oreos", serialNumber: String = "0044000007492", valueInDollars: Double = 2.75, quantity: Int = 1) {
        self.name = name
        self.priceInDollars = round(100*valueInDollars)/100
        self.barcodeNumber = serialNumber
        self.dateCreated = Date()
        self.quantity = quantity
        
        super.init()
    }
}
