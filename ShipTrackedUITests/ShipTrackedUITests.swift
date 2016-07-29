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
  func testUINetworkStub() {
    
    let app = XCUIApplication()
    app.navigationBars["Parcel List"].buttons["Add"].tap()
    
    let collectionViewsQuery = app.alerts["New Parcel"].collectionViews
    collectionViewsQuery.textFields["tracking number here"].tap()
    collectionViewsQuery.textFields["tracking number here"].typeText(trackingNumber)
    collectionViewsQuery.buttons["OK"].tap()
    
    XCTAssert(app.staticTexts[trackingNumber].exists)
    XCTAssert(app.staticTexts["false"].exists)
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    
    app.launchArguments.append(UITestingEnvironment)
    app.launchEnvironment += [endpointURLTesting: "Failed"]
    app.launch()
    
    sleep(1)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Properties
  let trackingNumber = "1Z202Y36A898759591"
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

