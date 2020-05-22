//
//  ViewController.swift
//  QRCodeReader
//
//  Created by ProgrammingWithSwift on 2018/08/31.
//  Copyright © 2018 ProgrammingWithSwift. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, ScannerDelegate {    
    private var scanner: Scanner?
    
    
    private var scannerRectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scanner = Scanner(withDelegate: self)
        
        guard let scanner = self.scanner else {
            return
        }
        
        scanner.requestCaptureSessionStartRunning()
        
        scannerRectView = self.getScannerRectView()
        
        self.view.addSubview(scannerRectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark - AVFoundation delegate methods
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        guard let scanner = self.scanner else {
            return
        }
        scanner.metadataOutput(output,
                               didOutput: metadataObjects,
                               from: connection)
        
        
    }
    
    func scannerRect() -> CGRect {
        let rect: CGRect =  CGRect(x: self.view.center.x - (self.view.frame.width * 0.667 / 2), y: self.view.frame.width * 0.667 / 4, width: self.view.frame.width * 0.667, height: self.view.frame.width * 0.667)
        
        return rect
    }
    
    func getScannerRectView() -> UIView {
        let view: UIView = UIView(frame: CGRect(x: self.view.center.x - (self.view.frame.width * 0.667 / 2), y: self.view.frame.width * 0.667 / 4, width: self.view.frame.width * 0.667, height: self.view.frame.width * 0.667))
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 5
        return view
    }
    
    // Mark - Scanner delegate methods
    func cameraView() -> UIView {
        return self.view
    }
    
    func delegateViewController() -> UIViewController {
        return self
    }
    
    func scanCompleted(withCode code: String) {
        print("SCAN COMPLETED")
        print(code)
        
        self.scannerRectView.layer.borderColor = UIColor.green.cgColor
    }
}
