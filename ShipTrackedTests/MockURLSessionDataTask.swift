//
//  MockURLSessionDataTask.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/24/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation
@testable import ShipTracked

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
  
  // MARK: Functions
  func resume() {
    resumeWasCalled = true
  }
  
  // MARK: Properties
  private (set) var resumeWasCalled = false
}