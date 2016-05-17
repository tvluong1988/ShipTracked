//
//  ParcelManager.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class ParcelManager {
  
  // MARK: Functions
  func addParcelWithTrackingNumber(trackingNumber: String) {
    upsService.requestParcelInfoWithTrackingNumber(trackingNumber)
  }
  
  // MARK: Lifecycle
  init() {
    parcels = [Parcel]()
  }
  
  // MARK: Properties
  private var parcels: [Parcel]
  
  private lazy var upsService: UPSService = {
    let service = UPSService()
    service.delegate = self
    return service
  }()
}

extension ParcelManager: UPSServiceDelegate {
  @objc func didReceiveData(data: AnyObject) {
    print("Did receive data: \(data)")
  }
}