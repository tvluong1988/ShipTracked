//
//  MockURLSession.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/23/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation
@testable import ShipTracked

class MockURLSession: URLSessionProtocol {
  
  // MARK: Functions
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
    lastRequest = request
    
    completionHandler(nextData, nextResponse, nextError)
    
    return nextDataTask
  }
  
  // MARK: Properties
  var nextDataTask = MockURLSessionDataTask()
  var nextData: NSData?
  var nextError: NSError?
  var nextResponse: NSHTTPURLResponse?
  private (set) var lastRequest: NSURLRequest?
}


class MockURLSessionDataTask: URLSessionDataTaskProtocol {
  
  // MARK: Functions
  func resume() {
    resumeWasCalled = true
  }
  
  // MARK: Properties
  private (set) var resumeWasCalled = false
}