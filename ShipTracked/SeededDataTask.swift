//
//  SeededDataTask.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/28/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class SeededDataTask: NSURLSessionDataTask {
  
  // MARK: Functions
  override func resume() {
    
    if let url = request.URL,
      let json = NSProcessInfo.processInfo().environment[url.absoluteString] {
      
      let response = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
      
      let data = json.dataUsingEncoding(NSUTF8StringEncoding)
      
      completionHandler(data, response, nil)
    }
    
  }
  
  // MARK: Lifecycle
  init(request: NSURLRequest, completionHandler: DataTaskResult) {
    self.request = request
    self.completionHandler = completionHandler
  }
  
  // MARK: Properties
  private let request: NSURLRequest
  private let completionHandler: DataTaskResult
}