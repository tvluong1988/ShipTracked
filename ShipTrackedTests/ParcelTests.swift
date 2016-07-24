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
  
  // MARK: Tests
  override func spec() {
    let trackingNumber = "1Z202Y36A898759591"
    var parcel: Parcel!
    
    describe("a parcel") {
      it("can be initialized with a tracking number") {
        parcel = nil
        
        expect(parcel).to(beFalsy())
        
        parcel = Parcel(trackingNumber: trackingNumber)
        
        expect(parcel).to(beTruthy())
        
      }
    }
    
    describe("given a parcel") {
      
      beforeEach() {
        parcel = Parcel(trackingNumber: trackingNumber)
        
      }
      
      afterEach() {
        parcel = nil
      }
      
      context("when it invalidates a tracking number") {
        it("then the parcel tracking number is invalid") {
          parcel = parcel.invalidateTrackingNumber()
          
          expect(parcel.isTrackingNumberValid).to(beFalse())
        }
      }
      
      context("when it validates a tracking number") {
        it("then the parcel tracking number is valid") {
          parcel = parcel.validateTrackingNumber()
          
          expect(parcel.isTrackingNumberValid).to(beTruthy())
        }
      }
    }
  }
}
