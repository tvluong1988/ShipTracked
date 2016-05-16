//
//  Parcel.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct Parcel {
  
  // MARK: Lifecycle
  init(trackingNumber: String) {
    self.trackingNumber = trackingNumber
    
  }
  
  // MARK: Properties
  var trackingNumber: String
  var isTrackingNumberValid: Bool = false
  
}