//
//  MockURLSession.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/23/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation
@testable import ShipTracked

class MockUPSService: UPSService {
  
}

class MockURLSession: URLSessionProtocol {
  var nextDataTask = MockURLSessionDataTask()
  var nextData: NSData?
  var nextError: NSError?
  var nextResponse: NSHTTPURLResponse?
  
  private (set) var lastRequest: NSURLRequest?
  
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
    lastRequest = request
    
    completionHandler(nextData, nextResponse, nextError)
    
    return nextDataTask
  }
  
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
  private (set) var resumeWasCalled = false
  
  func resume() {
    resumeWasCalled = true
  }
}