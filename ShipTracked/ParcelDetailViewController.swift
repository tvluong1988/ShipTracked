//
//  ViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class ParcelDetailViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var trackingNumberLabel: UILabel!
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    trackingNumberLabel.text = parcel?.trackingNumber
  }
  
  // MARK: Properties
  var parcel: Parcel?
  
}


