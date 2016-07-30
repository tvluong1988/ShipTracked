//
//  SeededDataTask.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/28/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation
import SwiftyJSON

class SeededDataTask: NSURLSessionDataTask {
  
  // MARK: Functions
  override func resume() {
    
    if let url = request.URL,
      let httpBody = request.HTTPBody {
      
      var response: NSHTTPURLResponse?
      var data: NSData?
      var error: NSError?
      
      let jsonHttpBody = JSON(data: httpBody)
      
      if let trackingNumber = jsonHttpBody["TrackRequest"]["InquiryNumber"].string,
        let jsonDataString = NSProcessInfo.processInfo().environment[trackingNumber] {
        
        response = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
        
        data = jsonDataString.dataUsingEncoding(NSUTF8StringEncoding)
        
        error = nil
      }
      
      completionHandler(data, response, error)
      
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