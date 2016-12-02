//
//  ViewController.swift
//  BarcodeScanning
//
//  Created by Quikcart
//  Copyright (c) 2015 Quikcart. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    /// Helper property and not directly used. The camera layer's bounds will be set to this.
    @IBOutlet weak var cameraView: UIView!
    /// Will show the type of metadata being displayed.
    @IBOutlet weak var lblDataType: UILabel!
    /// Will show the information from the capture metadata.
    @IBOutlet weak var lblDataInfo: UILabel!
    
    //MARK: Properties
    /// Runs the capture session.
    let captureSession = AVCaptureSession()
    /// The device used as input for the capture session.
    var captureDevice:AVCaptureDevice?
    /// The UI layer to display the feed from the input source, in our case, the camera.
    var captureLayer:AVCaptureVideoPreviewLayer?
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setupCaptureSession()
    }
    
    private func setupCaptureSession(){
        self.captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let deviceInput:AVCaptureDeviceInput
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(deviceInput)){
            // Show live feed
            captureSession.addInput(deviceInput)
            self.setupPreviewLayer({
                self.captureSession.startRunning()
                self.addMetaDataCaptureOutToSession()
            })
        } else {
            self.showError("Error while setting up input captureSession.")
        }
    }
    
    /**
     Handles setting up the UI to show the camera feed.
     
     - parameter completion: Completion handler to invoke if setting up the feed was successful.
     */
    private func setupPreviewLayer(completion:() -> ())
    {
        self.captureLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let capLayer = self.captureLayer {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = self.cameraView.frame
            self.view.layer.addSublayer(capLayer)
            completion()
        } else {
            self.showError("An error occured beginning video capture")
        }
    }
    
    //MARK: Metadata capture
    /**
     Handles identifying what kind of data output we want from the session, in our case, metadata and the available types of metadata.
     */
    private func addMetaDataCaptureOutToSession()
    {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    //MARK: Delegate Methods
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        for metadata in metadataObjects{
            let decodedData:AVMetadataMachineReadableCodeObject = metadata as! AVMetadataMachineReadableCodeObject
            self.lblDataInfo.text = decodedData.stringValue
            self.lblDataType.text = decodedData.type
        }
    }
    
    //MARK: Utility Functions
    /**
     Shows any error that may occur via an alert view.
     
     - parameter error: The error message.
     */
    private func showError(error:String)
    {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .Alert)
        let dismiss:UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{(alert:UIAlertAction) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(dismiss)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
