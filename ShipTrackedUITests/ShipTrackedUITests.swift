//
//  ShipTrackedUITests.swift
//  ShipTrackedUITests
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import XCTest

class ShipTrackedUITests: XCTestCase {
  
  // MARK: Tests
  func testUserAddValidTrackingNumber() {
    
    let app = XCUIApplication()
    app.navigationBars["Parcel List"].buttons["Add"].tap()
    
    let collectionViewsQuery = app.alerts["New Parcel"].collectionViews
    collectionViewsQuery.textFields["tracking number here"].tap()
    collectionViewsQuery.textFields["tracking number here"].typeText(validTrackingNumber)
    collectionViewsQuery.buttons["OK"].tap()
    
    XCTAssert(app.staticTexts[validTrackingNumber].exists)
    XCTAssert(app.staticTexts["true"].exists)
  }
  
  func testUserAddInvalidTrackingNumber() {
    
    let app = XCUIApplication()
    app.navigationBars["Parcel List"].buttons["Add"].tap()
    
    let collectionViewsQuery = app.alerts["New Parcel"].collectionViews
    collectionViewsQuery.textFields["tracking number here"].tap()
    collectionViewsQuery.textFields["tracking number here"].typeText(invalidTrackingNumber)
    collectionViewsQuery.buttons["OK"].tap()
    
    XCTAssert(app.staticTexts[invalidTrackingNumber].exists)
    XCTAssert(app.staticTexts["false"].exists)
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    
    let validDataResponse = NSString(data: createValidDataResponse(), encoding: NSUTF8StringEncoding)! as String
    
    let invalidDataResponse = NSString(data: createInvalidDataResponse(), encoding: NSUTF8StringEncoding)! as String
    
    
    app.launchArguments.append(UITestingEnvironment)
    app.launchEnvironment += [validTrackingNumber: validDataResponse, invalidTrackingNumber: invalidDataResponse]
    app.launch()
    
    sleep(1)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Properties
  let validTrackingNumber = "1Z202Y36A898759591"
  let invalidTrackingNumber = "1111"
  
  // JSON Testing Endpoint
  let endpointURLTesting = "https://wwwcie.ups.com/json/Track"
  
  let app = XCUIApplication()
  let UITestingEnvironment = "UI-TESTING"
}

func +=<K, V> (inout left: [K : V], right: [K : V]) {
  for (k, v) in right {
    left[k] = v
  }
}

