//
//  Parcel.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct Parcel: Equatable, Item {
  
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
  
  var startingAddress = Address()
  var endingAddress = Address()
  
  var activityAddresses = [Address]()
  
  var addressesToAnnotate: [Address] {
    var addresses = [self.startingAddress]
    addresses += self.activityAddresses
    
    return addresses
  }
  
}

func ==(lhs: Parcel, rhs: Parcel) -> Bool {
  return (lhs.trackingNumber == rhs.trackingNumber)
}