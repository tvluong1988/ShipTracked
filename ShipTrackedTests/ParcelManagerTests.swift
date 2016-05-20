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
  let parcelManager = ParcelManager()
  let validTrackingNumberForTesting = "1Z202Y36A898759591"
  let invalidTrackingNumberForTesting = "0000"
}



































