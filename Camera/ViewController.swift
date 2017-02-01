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
        
        var camDevice : AVCaptureDevice?
        let devices = AVCaptureDevice.devices()
        
        for device in devices! {
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)) {
                camDevice = device as? AVCaptureDevice
                if camDevice != nil  {
                    
                    let VideoSession = AVCaptureSession()
                    VideoSession.sessionPreset = AVCaptureSessionPresetHigh
                    
                    do {
                        let input = try AVCaptureDeviceInput(device: camDevice)
                        
                        
                        VideoSession.addInput(input)
                        
                        self.cameraLayer = AVCaptureVideoPreviewLayer(session: VideoSession)
                        print(" connection " , self.cameraLayer!.connection.isVideoMirroringSupported , self.cameraLayer!.connection.automaticallyAdjustsVideoMirroring);
                        
                        if (self.cameraLayer!.connection.isVideoMirroringSupported)
                        {
                            self.cameraLayer!.connection.automaticallyAdjustsVideoMirroring = false
                            self.cameraLayer!.connection.isVideoMirrored = true
                        }
                        self.cameraLayer!.frame = self.view.bounds
                        
                        self.view.layer = self.cameraLayer!
                        self.view.wantsLayer = true

                        VideoSession.startRunning()
                    }catch _ {
                        
                    }
                }
            }
        }
    }

}

