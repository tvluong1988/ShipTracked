//
//  SeededURLSession.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/28/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class SeededURLSession: NSURLSession {
  override func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> NSURLSessionDataTask {
    return SeededDataTask(request: request, completionHandler: completionHandler)
    
  }
}
