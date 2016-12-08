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
    
    func withCode(_ barcode: String) -> Int?{
        for (index, product) in allProducts.enumerated(){
            if product.barcodeNumber == barcode{
                return index
            }
        }
        return nil
    }
    
    func reduceQuantityWithCode(_ barcode: String){
        let index: Int = withCode(barcode)!
        if allProducts[index].quantity > 1{
            allProducts[index].quantity -= 1
        }
        else{
            allProducts.remove(at: index)
        }
    }
    
    func priceSum() -> Double{
        return allProducts.reduce(0.0) { $0 + ($1.priceInDollars ?? 0) }
    }
    
    func stringDescription() -> String{
        return "This store has \(allProducts.count) elements"
    }
    
}
