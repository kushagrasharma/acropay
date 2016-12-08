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
    
    func changeQuantityWithCode(_ barcode: String,_ quantity: Int){
        let index: Int = withCode(barcode)!
        let newQuantity = allProducts[index].quantity + quantity
        if newQuantity < 1{
            allProducts.remove(at: index)
        }
        else{
            allProducts[index].quantity = newQuantity
        }
    }
    
    func priceSum() -> Double{
        return allProducts.reduce(0.0) { $0 + ($1.priceInDollars ?? 0) }
    }
    
    func stringDescription() -> String{
        return "This store has \(allProducts.count) elements"
    }
    
}
