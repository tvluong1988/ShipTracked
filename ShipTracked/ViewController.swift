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
    
    parcelManager.addParcelWithTrackingNumber(invalidTrackingNumberForTesting)
    parcelManager.addParcelWithTrackingNumber(validTrackingNumberForTesting)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Properties
  let parcelManager = ParcelDataSource()
  let validTrackingNumberForTesting = "1Z202Y36A898759591"
  let invalidTrackingNumberForTesting = "0000"
  
}


