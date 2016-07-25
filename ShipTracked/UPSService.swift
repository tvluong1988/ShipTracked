//
//  UPSServiceManager.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class UPSService {
  
  func requestParcelWithTrackingNumber(trackingNumber: String, completionHandler: DataTaskResult) {
    
    if let body = createRequestBodyJSONWithTrackingNumber(trackingNumber),
      let request = createNSURLRequestWithBody(body)  {
      
      let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
      task.resume()
    }
  }
  
  // MARK: Inits
  init(session: URLSessionProtocol = NSURLSession.sharedSession()) {
    self.session = session
  }
  
  // MARK: Properties
  // JSON Production Endpoint
  private let endpointURLProduction = "https://onlinetools.ups.com/json/Track"
  
  // JSON Testing Endpoint
  private let endpointURLTesting = "https://wwwcie.ups.com/json/Track"
  
  private let username = "tvluong2"
  private let password = "t7!zAWK^x1$6"
  private let accessLicenseNumber = "DD0BE12EB3B46D36"
  private let requestOption = "7"
  
  private let session: URLSessionProtocol
}

// MARK: - Private Functions
private extension UPSService {
  
  func createNSURLRequestWithBody(body: NSData) -> NSURLRequest? {
    guard let url = NSURL(string: endpointURLTesting) else {
      return nil
    }
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.HTTPBody = body
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let staticRequest = request.copy() as? NSURLRequest
    return staticRequest
    
  }
  
  func createRequestBodyJSONWithTrackingNumber(trackingNumber: String) -> NSData? {
    
    let bodyDictionary: [String: AnyObject] =
      [
        "Security": [
          "UsernameToken": [
            "Username": username,
            "Password": password
          ],
          "UPSServiceAccessToken": [
            "AccessLicenseNumber": accessLicenseNumber
          ]
        ],
        "TrackRequest": [
          "Request": [
            "RequestAction": "Track",
            "RequestOption": requestOption
          ],
          "InquiryNumber": trackingNumber
        ]
    ]
    
    do {
      let bodyJSON = try NSJSONSerialization.dataWithJSONObject(bodyDictionary, options: .PrettyPrinted)
      return bodyJSON
      
    } catch {
      print(error)
      return nil
    }
    
  }
}







































