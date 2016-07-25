//
//  SessionProtocol.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/23/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

typealias DataTaskResult = (NSData?, NSURLResponse?, NSError?) -> Void

/**
 *  URLSessionProtocol for stubbing NSURLSession
 */
protocol URLSessionProtocol {
  
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol
  
}

// MARK: - URLSessionProtocol
extension NSURLSession: URLSessionProtocol {
  
  func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
    return (dataTaskWithRequest(request, completionHandler: completionHandler) as NSURLSessionDataTask) as URLSessionDataTaskProtocol
  }
  
}

/**
 *  URLSessionDataTaskProtocol for stubbing NSURLSessionDataTaskProtocol
 */
protocol URLSessionDataTaskProtocol {
  func resume()
}

extension NSURLSessionDataTask: URLSessionDataTaskProtocol {}
