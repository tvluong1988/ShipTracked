//
//  AddressSpec.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/30/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Quick
import Nimble
@testable import ShipTracked

class AddressSpec: QuickSpec {
  override func spec() {
    let fakeAddressLine = "1234 Grand Ave"
    let fakeCity = "Rochester"
    let fakeState = "MN"
    let fakePostalCode = "55901"
    let fakeCountry = "US"
    
    var address: Address!
    
    describe("given an Address object with valid full address") {
      
      address = Address(addressLine: fakeAddressLine, city: fakeCity, state: fakeState, postalCode: fakePostalCode, country: fakeCountry)
      
      context("when get full address is called") {
        it("then should get full address") {
          let expectedFullAddress = "\(fakeAddressLine) \(fakeCity) \(fakeState) \(fakePostalCode) \(fakeCountry)"
          let actualFullAddress = address.getFullAddress()
          
          expect(actualFullAddress).to(contain(expectedFullAddress))
        }
      }
      
    }
  }
}