//
//  Parcel.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct Parcel {
  
  // MARK: Functions
  func validateTrackingNumber() -> Parcel {
    return Parcel(trackingNumber: self.trackingNumber, isTrackingNumberValid: true)
  }
  
  func invalidateTrackingNumber() -> Parcel {
    return Parcel(trackingNumber: self.trackingNumber, isTrackingNumberValid: false)
  }
  
  // MARK: Lifecycle
  init(trackingNumber: String, isTrackingNumberValid: Bool = false) {
    self.trackingNumber = trackingNumber
    self.isTrackingNumberValid = isTrackingNumberValid
    
  }
  
  // MARK: Properties
  var trackingNumber: String
  var isTrackingNumberValid: Bool
  
}