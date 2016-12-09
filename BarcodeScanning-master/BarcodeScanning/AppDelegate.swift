//
//  AppDelegate.swift
//  BarcodeScanning
//
//  Created by Acropay
//  Copyright (c) 2016 Acropay. All rights reserved.
//

//Import appropriate swift libraries
import UIKit
import Stripe

// set constant variable
let MOLTIN_COLOR = UIColor(red: (139.0/255.0), green: (98.0/255.0), blue: (181.0/255.0), alpha: 1.0)

@UIApplicationMain
// App delegate is a subclass of UI Responder, but a delegate of UIApplication Delegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var productStore = ProductStore()
    
    // declare window variable, optional type
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // create viewController code...
        
        // Potential for applepay integration when developer account becomes available
        STPPaymentConfiguration.shared().publishableKey = "pk_test_lttP2oCNWtN1FTKiQMyBpS7M"
        STPPaymentConfiguration.shared().appleMerchantIdentifier = "your apple merchant identifier"
            return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

