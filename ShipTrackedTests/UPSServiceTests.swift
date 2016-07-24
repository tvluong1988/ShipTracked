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
      }
      
      context("when supplied with a tracking number") {
        it("should send a HTTP Post request at the correct UPS endpoint") {
          upsService.requestParcelInfoWithTrackingNumber(trackingNumber)
          
          expect(mockURLSession.lastRequest?.HTTPMethod).to(contain("POST"))
          expect(mockURLSession.lastRequest?.URL?.absoluteString).to(contain(endpointURLTesting))
          expect(mockURLSession.nextDataTask.resumeWasCalled).to(beTrue())
          
        }
      }
    }
    
  }
  
  
  // MARK: Mocks
  class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    private (set) var lastRequest: NSURLRequest?
    
    func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
      lastRequest = request
      
      return nextDataTask
    }
    
  }
  
  class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
      resumeWasCalled = true
    }
  }
}































