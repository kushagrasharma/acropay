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
    
    @discardableResult func createProduct() -> Product {
        let newProduct = Product()
        
        self.allProducts.append(newProduct)
        
        return newProduct

        
    // Gives controller accecss to the store 
    class ItemsViewController: UITableViewController {
            
            var productStore: ProductStore!
        }



