//
//  ViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let _ = upsService.requestParcelInfoWithTrackingNumber(upsService.validTrackingNumberForTesting)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Properties
  lazy var upsService: UPSService = {
    let manager = UPSService()
    manager.delegate = self
    return manager
  }()
}

extension ViewController: UPSServiceDelegate {
  func didReceiveData(data: AnyObject) {
    print("Did receive data: \(data)")
  }
}

