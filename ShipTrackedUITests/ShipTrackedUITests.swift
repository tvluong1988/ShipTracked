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
  func testUserSelectParcelFromTableView() {
    userAddTrackingNumber(validTrackingNumber)
    
    let validTrackingNumberElement = app.staticTexts[validTrackingNumber]
    waitForElementToAppear(validTrackingNumberElement)
    
    app.tables.staticTexts[validTrackingNumber].tap()
  }
  
  func testUserAddValidTrackingNumber() {
    
    userAddTrackingNumber(validTrackingNumber)
    
    let validTrackingNumberElement = app.staticTexts[validTrackingNumber]
    waitForElementToAppear(validTrackingNumberElement)
    
    XCTAssert(app.staticTexts["true"].exists)
  }
  
  func testUserAddInvalidTrackingNumber() {
    
    userAddTrackingNumber(invalidTrackingNumber)
    
    let invalidTrackingNumberElement = app.staticTexts[invalidTrackingNumber]
    waitForElementToAppear(invalidTrackingNumberElement)
    
    XCTAssert(app.staticTexts["false"].exists)
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    
    setUITestingEnvironment()
    addStubNetworkResponseInLaunchEnvironment()
    
    app.launch()
    
    sleep(5)
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

// MARK: - Private Functions
private extension ShipTrackedUITests {
  func setUITestingEnvironment() {
    app.launchArguments.append(UITestingEnvironment)
  }
  
  func addStubNetworkResponseInLaunchEnvironment() {
    let validDataResponse = NSString(data: createValidDataResponse(), encoding: NSUTF8StringEncoding)! as String
    
    let invalidDataResponse = NSString(data: createInvalidDataResponse(), encoding: NSUTF8StringEncoding)! as String
    
    app.launchEnvironment[validTrackingNumber] = validDataResponse
    app.launchEnvironment[invalidTrackingNumber] = invalidDataResponse
  }
  
  func userAddTrackingNumber(trackingNumber: String) {
    app.navigationBars["Parcel List"].buttons["Add"].tap()
    
    let collectionViewsQuery = app.alerts["New Parcel"].collectionViews
    collectionViewsQuery.textFields["tracking number here"].tap()
    collectionViewsQuery.textFields["tracking number here"].typeText(trackingNumber)
    collectionViewsQuery.buttons["OK"].tap()
  }
  
  func waitForElementToAppear(element: XCUIElement, file: String = #file, line: UInt = #line) {
    let existsPredicate = NSPredicate(format: "exists == true")
    expectationForPredicate(existsPredicate, evaluatedWithObject: element, handler: nil)
    
    waitForExpectationsWithTimeout(5) { (error) -> Void in
      if (error != nil) {
        let message = "Failed to find \(element) after 5 seconds."
        self.recordFailureWithDescription(message, inFile: file, atLine: line, expected: true)
      }
    }
  }
  
}
