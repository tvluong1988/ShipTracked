//
//  ParcelManagerTests.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/19/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import XCTest
@testable import ShipTracked

class ParcelManagerTests: XCTestCase {
  
  // MARK: Functions
  func testAddParcelWithTrackingNumberWithInvalidTrackingNumber() {
    XCTAssert(mockParcelManager.parcelCount == 0)
    
    let expectation = expectationWithDescription("ParcelManager retrieve parcel information from UPSService.")
    
    mockParcelManager.asyncExpectation = expectation
    
    mockParcelManager.addParcelWithTrackingNumber(invalidTrackingNumberForTesting)
    
    waitForExpectationsWithTimeout(1) {
      error in
      
      if let error = error {
        XCTFail("waitForExpectationWithTimeout errored: \(error)")
      }
      
      let parcel = self.mockParcelManager.getParcelAtIndex(0)
      XCTAssert(parcel.trackingNumber == self.invalidTrackingNumberForTesting)
      XCTAssert(parcel.isTrackingNumberValid == false)
    }
  }
  
  func testAddParcelWithTrackingNumberWithValidTrackingNumber() {
    XCTAssert(mockParcelManager.parcelCount == 0)
    
    let expectation = expectationWithDescription("ParcelManager retrieve parcel information from UPSService.")
    
    mockParcelManager.asyncExpectation = expectation
    
    mockParcelManager.addParcelWithTrackingNumber(validTrackingNumberForTesting)
    
    waitForExpectationsWithTimeout(1) {
      error in
      
      if let error = error {
        XCTFail("waitForExpectationWithTimeout errored: \(error)")
      }
      
      let parcel = self.mockParcelManager.getParcelAtIndex(0)
      XCTAssert(parcel.trackingNumber == self.validTrackingNumberForTesting)
      XCTAssert(parcel.isTrackingNumberValid == true)
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
  var mockParcelManager = MockParcelManager()
  let validTrackingNumberForTesting = "1Z202Y36A898759591"
  let invalidTrackingNumberForTesting = "0000"
}

class MockParcelManager: ParcelManager {
  var asyncExpectation: XCTestExpectation?
  
  override func didReceiveData(data: AnyObject) {
    super.didReceiveData(data)
    
    guard let expectation = asyncExpectation else {
      return
    }
    
    expectation.fulfill()
    
  }
}

































