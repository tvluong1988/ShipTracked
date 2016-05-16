//
//  ShipTrackedTests.swift
//  ShipTrackedTests
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import XCTest
@testable import ShipTracked

class ShipTrackedTests: XCTestCase {
  
  // MARK: Tests
  func testParcelInit() {
    var parcel: Parcel?
    
    XCTAssertNil(parcel)
    
    parcel = Parcel(trackingNumber: "0000")
    
    XCTAssertNotNil(parcel)
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
  
}
