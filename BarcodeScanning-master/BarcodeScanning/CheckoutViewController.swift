//
//  CheckoutViewController.swift
//  Acropay
//
//  Created by Faisal Younus on 12/8/16.
//  Copyright © 2016 Acropay. All rights reserved.
//

// Make necessary imports
import UIKit
import Stripe

// CheckoutViewController is a subclass of UIViewController, with delegate STPPayment...
class CheckoutViewController: UIViewController, STPPaymentContextDelegate {
    
    // Set constant the stripe key
    let stripePublishableKey = "pk_test_lttP2oCNWtN1FTKiQMyBpS7M"
    
    // Set backend URL
    let backendBaseURL: String? = "https://mysterious-river-36670.herokuapp.com/"
    
    // Potential for incorporation of apple pay, but dependant upon receiving developer license
    let appleMerchantID: String? = nil
    
    // Set company name
    let companyName = "AcroPay"
    
    // Set currency to US Dollars
    let paymentCurrency = "usd"
    let paymentContext: STPPaymentContext
    
    // Set theme, and checkout view conditions, etc
    let theme: STPTheme
    let paymentRow: CheckoutRowView
    let totalRow: CheckoutRowView
    let buyButton: BuyButton
    let rowHeight: CGFloat = 44
    
    // Possibly change to UIImage
    let productImage = UILabel()
    
    // App activity indicator showcasing that a task is in progress
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let numberFormatter: NumberFormatter

    // Progressing Payment animation
    var paymentInProgress: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                if self.paymentInProgress {
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1
                    self.buyButton.alpha = 0
                }
                else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    self.buyButton.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    init(price: Int, settings: Settings) {
        self.theme = settings.theme
        MyAPIClient.sharedClient.baseURLString = self.backendBaseURL
        
        // Setting up configuration and theme
        let config = STPPaymentConfiguration.shared()
        config.publishableKey = self.stripePublishableKey
        config.appleMerchantIdentifier = self.appleMerchantID
        config.companyName = self.companyName
        
        // potential to incorporate billing address for further verification purposes
        // config.requiredBillingAddressFields = settings.requiredBillingAddressFields
        config.additionalPaymentMethods = settings.additionalPaymentMethods
        config.smsAutofillDisabled = !settings.smsAutofillEnabled
        
        let paymentContext = STPPaymentContext(apiAdapter: MyAPIClient.sharedClient,configuration: config,theme: settings.theme)
        
        // Use this class to specify info that you've already collected from your user
        let userInformation = STPUserInformation()
        paymentContext.prefilledInformation = userInformation
        paymentContext.paymentAmount = price
        paymentContext.paymentCurrency = self.paymentCurrency
        self.paymentContext = paymentContext
        
        // Payment UI Profile
        self.paymentRow = CheckoutRowView(title: "Payment", detail: "Select Payment",
                                          theme: settings.theme)
        self.totalRow = CheckoutRowView(title: "Total", detail: "", tappable: false,
                                        theme: settings.theme)
        self.buyButton = BuyButton(enabled: true, theme: settings.theme)
        
        // Establish currency key
        var localeComponents: [String: String] = [
            NSLocale.Key.currencyCode.rawValue: self.paymentCurrency,
            ]
        localeComponents[NSLocale.Key.languageCode.rawValue] = NSLocale.preferredLanguages.first
        let localeID = NSLocale.localeIdentifier(fromComponents: localeComponents)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: localeID)
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        self.numberFormatter = numberFormatter
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        paymentContext.hostViewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.theme.primaryBackgroundColor
        var red: CGFloat = 0
        self.theme.primaryBackgroundColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        self.activityIndicator.activityIndicatorViewStyle = red < 0.5 ? .white : .gray
        self.navigationItem.title = "Complete Checkout"
        
        self.productImage.font = UIFont.systemFont(ofSize: 70)
        self.view.addSubview(self.totalRow)
        self.view.addSubview(self.paymentRow)
        self.view.addSubview(self.productImage)
        self.view.addSubview(self.buyButton)
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.alpha = 0
        self.buyButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
        self.paymentRow.onTap = { [weak self] _ in
            self?.paymentContext.pushPaymentMethodsViewController()
        }
    }
    
    // Establish constant parameters for product image placement and layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = self.view.bounds.width
        self.productImage.sizeToFit()
        self.productImage.center = CGPoint(x: width/2.0,
                                           y: self.productImage.bounds.height/2.0 + rowHeight)
        self.paymentRow.frame = CGRect(x: 0, y: self.productImage.frame.maxY + rowHeight,
                                       width: width, height: rowHeight)
        self.totalRow.frame = CGRect(x: 0, y: self.paymentRow.frame.maxY,
                                     width: width, height: rowHeight)
        self.buyButton.frame = CGRect(x: 0, y: 0, width: 88, height: 44)
        self.buyButton.center = CGPoint(x: width/2.0, y: self.totalRow.frame.maxY + rowHeight*1.5)
        self.activityIndicator.center = self.buyButton.center
    }
    
    // verifies tapping of buy
    func didTapBuy() {
        self.paymentInProgress = true
        self.paymentContext.requestPayment()
    }
    
    // MARK: STPPaymentContextDelegate
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        MyAPIClient.sharedClient.completeCharge(paymentResult, amount: self.paymentContext.paymentAmount,
                                                completion: completion)
    }
    
    // Payment verifier function
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        self.paymentInProgress = false
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "You've checked out!"
        case .userCancellation:
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.paymentRow.loading = paymentContext.loading
        if let paymentMethod = paymentContext.selectedPaymentMethod {
            self.paymentRow.detail = paymentMethod.label
        }
        else {
            self.paymentRow.detail = "Select Payment"
        }
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
    }
    
    // "`STPPaymentContext` keeps track of all of the state around a payment. It will manage fetching a user's saved payment methods, tracking any information they select, and prompting them for required additional information before completing their purchase. It can be used to power your application's "payment confirmation" page." 
    // Further error handling
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            _ = self.navigationController?.popViewController(animated: true)
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.paymentContext.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
}

