//
//  ProductViewController.swift
//  BarcodeScanning
//
//  Created by Kushagra Sharma on 12/5/16.
//  Copyright © 2016 Acropay. All rights reserved.
//


import UIKit
import Moltin

class ProductViewController: UIViewController {
    
    var product:Product?
    
    @IBOutlet weak var descriptionTextView:UITextView?
    @IBOutlet weak var productImageView:UIImageView?
    @IBOutlet weak var buyButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = product?.name
        buyButton?.backgroundColor = MOLTIN_COLOR
        
        // Do any additional setup after loading the view.
        if let description = product!.productDescription as String? {
            self.descriptionTextView?.text = description
            
        }
        
        let buyButtonTitle = "Buy Now $" + String(format: "%.2f", product!.priceInDollars)
        self.buyButton?.setTitle(buyButtonTitle, for: UIControlState())
        
        var imageUrl = ""
        
        if product!.images.count > 0{
            imageUrl = product!.images[0]!
        }
        
        productImageView?.sd_setImage(with: URL(string:imageUrl))
        
        
    }
    
    @IBAction func buyProduct(_ sender: AnyObject) {
        // Add the current product to the cart
        
        performSegue(withIdentifier: "addToCart", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Product has been added to cart
        if segue.identifier == "addToCart"{
            let destinationViewController = segue.destination as! CartViewController
            if destinationViewController.productStore == nil{
                destinationViewController.productStore = ProductStore()
                destinationViewController.productStore!.addProduct(self.product!)
            }
            else{
                destinationViewController.productStore!.addProduct(self.product!)
            }
            
        }
    }
    
    
    
}
