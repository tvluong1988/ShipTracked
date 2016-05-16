//
//  UPSServiceManager.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class UPSServiceManager {
  
  // MARK: Functions
  func getParcelWithTrackingNumber(trackingNumber: String) -> Parcel {
    let parcel = Parcel(trackingNumber: trackingNumber)
    
    return parcel
  }
  
  // MARK: Properties
  
}
