//
//  ViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit
import MapKit

class ParcelDetailViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var trackingNumberLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    trackingNumberLabel.text = parcel?.trackingNumber
    
    print("Parcel info: \(parcel)")
    
    var address = "\(parcel?.startingAddress)"
  }
  
  // MARK: Properties
  var parcel: Parcel?
  let geocoder = CLGeocoder()
  
}


