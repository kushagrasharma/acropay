//
//  ViewController.swift
//  BarcodeScanning
//
//  Created by Jordan Morgan on 5/16/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var lblDataType: UILabel!
    @IBOutlet weak var lblDataInfo: UILabel!
    
    //MARK: Properties
    let captureSession = AVCaptureSession()
    var captureDevice:AVCaptureDevice?
    var captureLayer:AVCaptureVideoPreviewLayer?
    
    //MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.setupCaptureSession()
    }
    
    //MARK: Session Startup
    fileprivate func setupCaptureSession()
    {
        self.captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do{
            let deviceInput = try AVCaptureDeviceInput(device: self.captureDevice) as AVCaptureDeviceInput?
            //Add the input feed to the session and start it
            self.captureSession.addInput(deviceInput)
            self.setupPreviewLayer({
                self.captureSession.startRunning()
                self.addMetaDataCaptureOutToSession()
            })
        }
        catch let error as NSError{
            self.showError(error.localizedDescription)
        }
        
        
    }
    
    fileprivate func setupPreviewLayer(_ completion:() -> ())
    {
        self.captureLayer = AVCaptureVideoPreviewLayer(session: self.captureSession) as AVCaptureVideoPreviewLayer
        
        if let capLayer = self.captureLayer
        {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = self.cameraView.frame
            self.view.layer.addSublayer(capLayer)
            completion()
        }
        else
        {
            
            self.showError("An error occured beginning video capture.")
        }
    }
    
    //MARK: Metadata capture
    fileprivate func addMetaDataCaptureOutToSession()
    {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }
    
    //MARK: Delegate Methods
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        for metaData in metadataObjects
        {
            let decodedData:AVMetadataMachineReadableCodeObject = metaData as! AVMetadataMachineReadableCodeObject
            self.lblDataInfo.text = decodedData.stringValue
            self.lblDataType.text = decodedData.type
            performSegue(withIdentifier: "barcodeScannedSegue", sender: self)
            break
        }
    }
    
    //MARK: IBAction Functions
    
    @IBAction func showCart(_ sender: UIButton){
        performSegue(withIdentifier: "showCartSegue", sender: self)
    }
    
    //MARK: Utility Functions
    fileprivate func showError(_ error:String)
    {

        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let dismiss:UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler:{(alert:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(dismiss)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If barcode has been scanned and segueing to product page
        if segue.identifier == "barcodeScannedSegue"{
            let destinationViewController = segue.destination as! ProductViewController
            destinationViewController.barcodeString = self.lblDataInfo.text!
        }
    }
    
    class ContainerViewController: SlideMenuController {
        
        override func awakeFromNib() {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Main") {
                self.mainViewController = controller
            }
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Left") {
                self.leftViewController = controller
            }
            super.awakeFromNib()
        }
        
    }

}

