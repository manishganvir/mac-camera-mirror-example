//
//  ViewController.swift
//  Camera
//
//  Created by Ganvir, Manish (Contractor) on 1/31/17.
//  Copyright © 2017 Comcast. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    var cameraLayer : AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        self.startCamera()
    }
    
    func startCamera() {
        
        var frontCamera : AVCaptureDevice?
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices
        for device in devices! {
            // Make sure this particular device supports video
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)) {
                frontCamera = device as? AVCaptureDevice
                if frontCamera != nil  {
                    
                    let frontVideoSession = AVCaptureSession()
                    frontVideoSession.sessionPreset = AVCaptureSessionPresetHigh
                    
                    do {
                        let input = try AVCaptureDeviceInput(device: frontCamera)
                        
                        
                        frontVideoSession.addInput(input)
                        
                        self.cameraLayer = AVCaptureVideoPreviewLayer(session: frontVideoSession)
                        self.cameraLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                        print(" connection " , self.cameraLayer!.connection.isVideoMirroringSupported , self.cameraLayer!.connection.automaticallyAdjustsVideoMirroring);
                        
                        if (self.cameraLayer!.connection.isVideoMirroringSupported)
                        {
                            self.cameraLayer!.connection.automaticallyAdjustsVideoMirroring = false
                            self.cameraLayer!.connection.isVideoMirrored = true
                        }
                        self.cameraLayer!.frame = self.view.bounds
                        
                        self.view.layer = self.cameraLayer!
                        self.view.wantsLayer = true
                        
                        //let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        //dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        frontVideoSession.startRunning()
                        //}
                    }catch _ {
                        
                    }
                }
            }
        }
    }

}

