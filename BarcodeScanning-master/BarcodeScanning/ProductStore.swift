//
//  ProductStore.swift
//  BarcodeScanning
//
//  Created by Faisal Younus on 12/8/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

import UIKit

class ProductStore {
    
    var allProducts = [Product]()
    
    func addProduct(_ product: Product){
        
        self.allProducts.append(product)
        
    }
}
