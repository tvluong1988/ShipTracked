//
//  Address.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct Address: Equatable {
  
  // MARK: Properties
  var addressLine: String?
  var city: String?
  var state: String?
  var postalCode: String?
  var country: String?
  
  func getFullAddress() -> String {
    var fullAddress = ""
    
    
    
    return fullAddress
  }
}

func ==(lhs: Address, rhs: Address) -> Bool {
  return (lhs.addressLine == rhs.addressLine)
    && (lhs.city == rhs.city)
    && (lhs.state == rhs.state)
    && (lhs.postalCode == rhs.postalCode)
    && (lhs.country == rhs.country)
}
