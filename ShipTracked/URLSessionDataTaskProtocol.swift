//
//  URLSessionDataTaskProtocol.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/24/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

/**
 *  URLSessionDataTaskProtocol for stubbing NSURLSessionDataTaskProtocol
 */
protocol URLSessionDataTaskProtocol {
  func resume()
}

extension NSURLSessionDataTask: URLSessionDataTaskProtocol {}