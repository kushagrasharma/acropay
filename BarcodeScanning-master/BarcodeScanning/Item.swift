//
//  Item.swift
//  BarcodeScanning
//
//  Created by Faisal Younus on 12/7/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var priceInDollars: Int
    var barcodeNumber: String
    var image: UIImage?
    let dateCreated: Date
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.priceInDollars = valueInDollars
        self.barcodeNumber = serialNumber!
        self.dateCreated = Date()
        
        super.init()
    }
}
