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
  func testGetParcelWithTrackingNumberValidated() {
    let parcel = upsService.getParcelWithTrackingNumber("000")
    
    XCTAssert(parcel.isTrackingNumberValid == true)
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
  let upsService = UPSService()
}