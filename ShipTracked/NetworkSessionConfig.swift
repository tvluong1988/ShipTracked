//
//  NetworkSessionConfig.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/28/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct NetworkSessionConfig {
  // MARK: Enum
  enum TestingConfig: String {
    case UITesting = "UI-TESTING"
  }
  
  // MARK: Properties
  static let urlSession: NSURLSession = isUITesting() ? SeededURLSession() : NSURLSession.sharedSession()
}

/**
 Check to see if application is running in UI Testing environment
 
 - returns: running in UI Testing environment or not
 */
private func isUITesting() -> Bool {
  return NSProcessInfo.processInfo().arguments.contains(NetworkSessionConfig.TestingConfig.UITesting.rawValue)
}