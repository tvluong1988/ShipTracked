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
    
    let _ = upsServiceManager.requestParcelInfoWithTrackingNumber(upsServiceManager.validTrackingNumberForTesting)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Properties
  lazy var upsServiceManager: UPSServiceManager = {
    let manager = UPSServiceManager()
    manager.delegate = self
    return manager
  }()
}

extension ViewController: UPSServiceManagerDelegate {
  func didReceiveData(data: AnyObject) {
    print("Did receive data: \(data)")
  }
}

