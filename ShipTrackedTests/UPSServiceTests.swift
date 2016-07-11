//
//  UPSServiceManagerTests.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import XCTest
@testable import ShipTracked

class UPSServiceTests: XCTestCase {
  
  // MARK: Tests
  func testRequestParcelInfoWithValidTrackingNumber() {
    let expectation = expectationWithDescription("upsService calls the delegate.")
    spyDelegate.asyncExpectation = expectation
    
    upsService.requestParcelInfoWithTrackingNumber(validTrackingNumberForTesting)
    
    waitForExpectationsWithTimeout(5) {
      error in
      if let error = error {
        XCTFail("waitForExpectationWithTimeout errored: \(error)")
      }
      
      if self.spyDelegate.asyncResult == nil {
        XCTFail("Expected delegate to be called")
        return
      }
      
    }
    
  }
  
  func testRequestParcelInfoWithInvalidTrackingNumber() {
    let expectation = expectationWithDescription("upsService calls the delegate.")
    spyDelegate.asyncExpectation = expectation
    
    upsService.requestParcelInfoWithTrackingNumber(invalidTrackingNumberForTesting)
    
    waitForExpectationsWithTimeout(5) {
      error in
      if let error = error {
        XCTFail("waitForExpectationWithTimeout errored: \(error)")
      }
      
      if self.spyDelegate.asyncResult == nil {
        XCTFail("Expected delegate to be called")
        return
      }
      
    }
    
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  // MARK: Properties
  
  lazy var upsService: UPSService = {
    let service = UPSService()
    service.delegate = self.spyDelegate
    return service
  }()
  
  var spyDelegate = SpyUPSServiceDelegate()
  
  private let validTrackingNumberForTesting = "1Z202Y36A898759591"
  private let invalidTrackingNumberForTesting = "0000"
  
}

class SpyUPSServiceDelegate: UPSServiceDelegate {
  var asyncResult: AnyObject?
  
  var asyncExpectation: XCTestExpectation?
  
  @objc func didReceiveData(data: AnyObject) {
    guard let expectation = asyncExpectation else {
      XCTFail("SpyUPSServiceDelegate was not setup correctly. Missing XCTestExpectation reference.")
      return
    }
    
    asyncResult = data
    expectation.fulfill()
  }
}































