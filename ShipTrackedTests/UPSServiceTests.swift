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
        
        self.didFinishWithErrorWasCalled = false
        self.didReceiveDataWasCalled = false
      }
      
      context("when requesting parcel info with a tracking number") {
        it("then it should send a HTTP Post request at the correct UPS endpoint") {
          upsService.requestParcelWithTrackingNumber(trackingNumber) {
            _,_,_ in
            return
          }
          
          expect(mockURLSession.lastRequest?.HTTPMethod).to(contain("POST"))
          expect(mockURLSession.lastRequest?.URL?.absoluteString).to(contain(endpointURLTesting))
          expect(mockURLSession.nextDataTask.resumeWasCalled).to(beTrue())
          
        }
        
        context("when response fails with mock error") {
          it("then it should receive mock error") {
            let expectedError = NSError(domain: "fake error", code: 1, userInfo: nil)
            
            mockURLSession.nextError = expectedError
            
            var actualError: NSError?
            upsService.requestParcelWithTrackingNumber(trackingNumber) {
              _,_,error in
              actualError = error
            }
            
            expect(actualError).toEventually(be(expectedError))
          }
        }
        
        context("when response succeeds with mock received data") {
          it("then it should receive mock data") {
            
            let fakeJSON = ["fake_key": "fake_value"]
            
            let expectedData = try! NSJSONSerialization.dataWithJSONObject(fakeJSON, options: .PrettyPrinted)
            
            mockURLSession.nextData = expectedData
            
            var actualData: NSData?
            upsService.requestParcelWithTrackingNumber(trackingNumber) {data,_,_ in
              actualData = data
            }
            
            expect(actualData).toEventually(be(expectedData))
          }
        }
        
        context("when response returns with mock response status") {
          it("then it should receive mock response status") {
            let expectedResponse = NSHTTPURLResponse(URL: NSURL(string: "fake_url")!, statusCode: 200, HTTPVersion: nil, headerFields: nil)
            
            mockURLSession.nextResponse = expectedResponse
            
            var actualResponse: NSHTTPURLResponse?
            upsService.requestParcelWithTrackingNumber(trackingNumber) {
              _,response,_ in
              actualResponse = response as? NSHTTPURLResponse
            }
            
            expect(actualResponse).to(be(expectedResponse))
            
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































