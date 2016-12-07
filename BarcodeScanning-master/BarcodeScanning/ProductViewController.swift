//
//  ProductViewController.swift
//  BarcodeScanning
//
//  Created by Kushagra Sharma on 12/5/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

import UIKit
import SwiftyJSON

class  ProductViewController: UIViewController {
    var barcodeString:String = ""
    @IBOutlet var productName : UILabel!
    @IBOutlet var productPrice : UILabel!
    
    @IBAction func addToCart(_ sender: UIButton){
        performSegue(withIdentifier: "productAddedToCart", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productName.text = self.barcodeString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductData(_ barcodeString: String){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
