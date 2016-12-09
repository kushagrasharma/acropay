//
//  CartViewController.swift
//  MoltinSwiftExample
//
//  Created by Kushagra Sharma on 12/8/16.
//  Copyright (c) 2016 Acropay. All rights reserved.
//
import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate {
    
    fileprivate let CART_CELL_REUSE_IDENTIFIER = "CartTableViewCell"
    
    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var totalLabel:UILabel?
    @IBOutlet weak var checkoutButton:UIButton?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
        for cell in self.tableView?.visibleCells as! [CartTableViewCell]{
            cell.setItemQuantity(appDelegate.productStore.allProducts[appDelegate.productStore.withCode(cell.productId!)!].quantity)
        }
        print(appDelegate.productStore.stringDescription())
        // Reset cart total
        self.totalLabel?.text = "$" + String(format: "%.2f", self.appDelegate.productStore.priceSum())
        // And reload table of cart items...
        self.tableView?.reloadData()
        
        // Disable checkout button if no items in cart
        self.checkoutButton?.isEnabled = self.appDelegate.productStore.allProducts.count > 0
        if (self.checkoutButton?.isEnabled)!{
            self.checkoutButton?.backgroundColor = MOLTIN_COLOR
        }
        else{
            self.checkoutButton?.backgroundColor = UIColor.gray
        }
    }
    
    // MARK: - TableView Data source & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.productStore.allProducts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CART_CELL_REUSE_IDENTIFIER, for: indexPath) as! CartTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        let product:Product = appDelegate.productStore.allProducts[row]
        
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
        appDelegate.productStore.allProducts.remove(at: index)
        self.refreshCart()
    }
    
    
    // MARK: - Cell delegate
    func cartTableViewCellSetQuantity(_ cell: CartTableViewCell, quantity: Int) {
        // The cell's quantity's been updated by the stepper control - tell the productStore and refresh cart
        // If quantity = 0, remove item
        
        // Loading UI..
        appDelegate.productStore.setQuantityWithCode(cell.productId!, quantity)
        
        self.reloadCellAtIndex(indexPath: (self.tableView?.indexPath(for: cell))!)
        self.refreshCart()
    }
    
    private func reloadCellAtIndex(indexPath: IndexPath) {
        tableView?.beginUpdates()
        tableView?.reloadRows(at: [indexPath], with: .automatic)
        tableView?.endUpdates()
    }
    
    // MARK: - Checkout button
    @IBAction func checkoutButtonClicked(_ sender: AnyObject) {
        let checkoutViewController = CheckoutViewController(price: Int(100*appDelegate.productStore.priceSum()),
                                                            settings: SettingsViewController().settings)
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    
    // http://stackoverflow.com/questions/32931731/ios-swift-update-uitableview-custom-cell-label-outside-of-tableview-cellforrow
    
    
    
}
