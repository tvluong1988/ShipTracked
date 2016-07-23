//
//  ShipTrackedTests.swift
//  ShipTrackedTests
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Quick
import Nimble
@testable import ShipTracked


class ParcelSpec: QuickSpec {
  override func spec() {
    
    describe("a parcel") {
      //      var parcel: Parcel
      let trackingNumber = "1111"
      var parcel: Parcel!
      
      beforeEach() {
        parcel = Parcel(trackingNumber: trackingNumber)
        
      }
      
      it("can be initialized with a tracking number") {
        var parcel: Parcel?
        
        expect(parcel).to(beFalsy())
        
        parcel = Parcel(trackingNumber: trackingNumber)
        
        expect(parcel).to(beTruthy())
        
      }
      
      
      context("that is initialized") {
        it("can invalidate a tracking number") {
          parcel = parcel.invalidateTrackingNumber()
          
          expect(parcel.isTrackingNumberValid).to(beFalse())
        }
        
        it("can validate a tracking number") {
          parcel = parcel.validateTrackingNumber()
          
          expect(parcel.isTrackingNumberValid).to(beTrue())
        }
      }
    }
  }
}
