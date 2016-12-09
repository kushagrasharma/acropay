//
//  CartTableViewCell.swift
//  Acropay
//
//  Created by Kushagra Sharma on 12/8/16
//  Copyright (c) 2016 Acropay. All rights reserved.
//  Adapted from https://github.com/moltin/ios-swift-example

import UIKit

protocol CartTableViewCellDelegate {
    func cartTableViewCellSetQuantity(_ cell: CartTableViewCell, quantity: Int)
}

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView:UIImageView?
    @IBOutlet weak var itemTitleLabel:UILabel?
    @IBOutlet weak var itemPriceLabel:UILabel?
    @IBOutlet weak var itemQuantityLabel:UILabel?
    @IBOutlet weak var itemQuantityStepper:UIStepper?
    
    var delegate:CartTableViewCellDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var productId:String?

    var quantity:Int {
        get {
            if (self.itemQuantityStepper != nil) {
                return appDelegate.productStore.allProducts[appDelegate.productStore.withCode(productId!)!].quantity
            }
            
            return 0
        }
        
        set {
            self.setItemQuantity(quantity)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItemDictionary(_ itemDict: Product) {
        
        itemTitleLabel?.text = itemDict.name
        
        itemPriceLabel?.text = "$" + String(format: "%.2f", itemDict.priceInDollars)
        
        self.productId = itemDict.barcodeNumber
        
        let qty:NSNumber = itemDict.quantity as NSNumber
        _ = "Qty. \(qty.intValue)"
        self.itemQuantityStepper?.value = qty.doubleValue
        
        var imageUrl = ""
        
        if itemDict.images.count > 0{
            imageUrl = itemDict.images[0]!
        }
        
        itemImageView?.sd_setImage(with: URL(string:imageUrl))

    }
    
    @IBAction func stepperValueChanged(_ sender: AnyObject){
        let value = Int(itemQuantityStepper!.value)
        
        setItemQuantity(value)
        
    }
    
    func setItemQuantity(_ quantity: Int) {
        appDelegate.productStore.productWithCode(self.productId!)?.quantity = quantity
        let itemQuantityText = "Qty. \(quantity)"
        itemQuantityLabel?.text = itemQuantityText
        
        itemQuantityStepper?.value = Double(quantity)
        
        // Notify delegate, if there is one, too...
        if (delegate != nil) {
            delegate?.cartTableViewCellSetQuantity(self, quantity: quantity)
        }
        
    }

}
