//
//  CartViewController.swift
//  MoltinSwiftExample
//
//  Created by Dylan McKee on 15/08/2015.
//  Copyright (c) 2015 Moltin. All rights reserved.
//

import UIKit
import Moltin

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate {
    
    fileprivate let CART_CELL_REUSE_IDENTIFIER = "CartTableViewCell"
    
    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var totalLabel:UILabel?
    @IBOutlet weak var checkoutButton:UIButton?
    
    var productStore: ProductStore? = ProductStore()
    
    fileprivate let BILLING_ADDRESS_SEGUE_IDENTIFIER = "showBillingAddress"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Cart"
        
        totalLabel?.text = ""
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // only need to refresh cart if coming from add product page, not barcode page
        refreshCart()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshCart() {
        SwiftSpinner.show("Updating cart")
        
        // Reset cart total
        self.totalLabel?.text = "$" + String(format: "%.2f", self.productStore!.priceSum())
        // And reload table of cart items...
        self.tableView?.reloadData()

        // Hide loading UI
        SwiftSpinner.hide()
        // Disable checkout button if no items in cart
        self.checkoutButton?.isEnabled = self.productStore!.allProducts.count > 0
        
    }
    
    // MARK: - TableView Data source & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productStore!.allProducts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CART_CELL_REUSE_IDENTIFIER, for: indexPath) as! CartTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        let product:Product = productStore!.allProducts[row]
        
        cell.setItemDictionary(product)
        
        cell.delegate = self
        
        return cell
    }
    
    
    
    func tableView(_ _tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            // Remove the item from the cart.
            removeItemFromCartAtIndex((indexPath as NSIndexPath).row)
        }
    }
    
    fileprivate func removeItemFromCartAtIndex(_ index: Int) {
        SwiftSpinner.show("Updating cart")
        self.productStore!.allProducts.remove(at: index)
        self.refreshCart()
        SwiftSpinner.hide()
    }
    
    
    // MARK: - Cell delegate
    func cartTableViewCellSetQuantity(_ cell: CartTableViewCell, quantity: Int) {
        // The cell's quantity's been updated by the stepper control - tell the productStore and refresh cart
        // If quantity = 0, remove item
        
        // Loading UI..
        SwiftSpinner.show("Updating quantity")
        
        self.productStore!.setQuantityWithCode(cell.productId!, quantity)
        
        
        self.refreshCart()
        
        SwiftSpinner.hide()
        
    }
    
    // MARK: - Checkout button
    @IBAction func checkoutButtonClicked(_ sender: AnyObject) {
        let checkoutViewController = CheckoutViewController(price: Int(100*self.productStore!.priceSum()),
                                                            settings: SettingsViewController().settings)
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    
}

