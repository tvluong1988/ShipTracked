//
//  SessionProtocol.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/23/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

typealias DataTaskResult = (NSData?, NSURLResponse?, NSError?) -> Void

protocol URLSessionProtocol {
  
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol
  
}

extension NSURLSession: URLSessionProtocol {
  
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
    return (dataTaskWithRequest(request, completionHandler: completionHandler) as NSURLSessionDataTask) as URLSessionDataTaskProtocol
  }
  
}


protocol URLSessionDataTaskProtocol {
  func resume()
}

extension NSURLSessionDataTask: URLSessionDataTaskProtocol {}
