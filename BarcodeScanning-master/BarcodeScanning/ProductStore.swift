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
        if let index = withCode(product.barcodeNumber){
            allProducts[index].quantity += 1
        }
        else{
            self.allProducts.append(product)
        }
    }
    
    func withCode(_ barcode: String) -> Int?{
        for (index, product) in allProducts.enumerated(){
            if product.barcodeNumber == barcode{
                return index
            }
        }
        return nil
    }
    
    func productWithCode(_ barcode: String) -> Product?{
        return allProducts[self.withCode(barcode)!]
    }
    
    func setQuantityWithCode(_ barcode: String,_ quantity: Int){
        let index: Int = withCode(barcode)!
        if quantity == 0{
            allProducts.remove(at: index)
        }
        else{
            allProducts[index].quantity = quantity
        }
    }
    
    func priceSum() -> Double{
        var sum: Double = 0
        for product in allProducts{
            sum += (product.priceInDollars*Double(product.quantity))
        }
        return sum
    }
    
    func stringDescription() -> String{
        var x = "This store has \(allProducts.count) elements "
        for product in allProducts{
            x += "[\(product.name) \(product.quantity) "
        }
        return x
    }
    
}
