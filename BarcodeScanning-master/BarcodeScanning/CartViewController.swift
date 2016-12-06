//
//  CartViewController.swift
//  BarcodeScanning
//
//  Created by Kushagra Sharma on 12/5/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    var barcodeString:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.barcodeString)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
