//
//  UPSServiceManagerTests.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Quick
import Nimble
@testable import ShipTracked

class UPSServiceSpec: QuickSpec {
  
  // MARK: Test
  override func spec() {
    
    var upsService: UPSService!
    let mockURLSession = MockURLSession()
    
    // JSON Production Endpoint
    //    let endpointURLProduction = "https://onlinetools.ups.com/json/Track"
    
    // JSON Testing Endpoint
    let endpointURLTesting = "https://wwwcie.ups.com/json/Track"
    
    let trackingNumber = "1Z202Y36A898759591"
    
    
    describe("given a UPSService") {
      
      beforeEach() {
        upsService = UPSService(session: mockURLSession)
        upsService.delegate = self
      }
      
      context("when requesting parcel info with a tracking number") {
        it("should send a HTTP Post request at the correct UPS endpoint") {
          upsService.requestParcelInfoWithTrackingNumber(trackingNumber)
          
          expect(mockURLSession.lastRequest?.HTTPMethod).to(contain("POST"))
          expect(mockURLSession.lastRequest?.URL?.absoluteString).to(contain(endpointURLTesting))
          expect(mockURLSession.nextDataTask.resumeWasCalled).to(beTrue())
          
        }
        
        context("received error") {
          it("should call delegate didFinishWithError") {
            let error = NSError(domain: "fake error", code: 1, userInfo: nil)
            
            mockURLSession.nextError = error
            
            upsService.requestParcelInfoWithTrackingNumber(trackingNumber)
            
            expect(self.didFinishWithErrorWasCalled).toEventually(beTrue())
          }
        }
        
        context("received data") {
          it("should call delegate didReceiveData") {
            
            let fakeJSON = ["fake_key": "fake_value"]
            
            let data = try! NSJSONSerialization.dataWithJSONObject(fakeJSON, options: .PrettyPrinted)
            
            mockURLSession.nextData = data
            
            upsService.requestParcelInfoWithTrackingNumber(trackingNumber)
            
            expect(self.didReceiveDataWasCalled).toEventually(beTrue())
          }
        }
      }
    }
  }
  
  // MARK: Properties
  var didFinishWithErrorWasCalled = false
  var didReceiveDataWasCalled = false
}

extension UPSServiceSpec: UPSServiceDelegate {
  func didReceiveData(data: AnyObject) {
    didReceiveDataWasCalled = true
  }
  
  func didFinishWithError(error: NSError) {
    didFinishWithErrorWasCalled = true
  }
}































