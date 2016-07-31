//
//  AddressPlacemarkSession.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/30/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation
import CoreLocation

class AddressPlacemarkSession {
  static let sharedSession = AddressPlacemarkSession()
  
  var addressBook = [String: CLPlacemark]()
}
