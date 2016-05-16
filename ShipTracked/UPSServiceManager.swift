//
//  UPSServiceManager.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class UPSServiceManager {
  
  // MARK: Functions
  func getParcelWithTrackingNumber(trackingNumber: String) -> Parcel {
    let parcel = Parcel(trackingNumber: trackingNumber)
    
    return updateParcelInformationFromAPI(parcel)
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
  
  private let session = NSURLSession.sharedSession()
  
  let validTrackingNumberForTesting = "1Z202Y36A898759591"
  
}

// MARK: - Private Functions
private extension UPSServiceManager {
  func updateParcelInformationFromAPI(parcel: Parcel) -> Parcel {
    sendDataTaskWithTrackingNumber(parcel.trackingNumber)
    return parcel.validateTrackingNumber()
  }
  
  func sendDataTaskWithTrackingNumber(trackingNumber: String) {
    guard let body = createRequestBodyJSONWithTrackingNumber(trackingNumber),
      let request = createNSURLRequestWithBody(body) else {
        return
    }
    
    sendDataTaskWithRequest(request)
    
  }
  
  func sendDataTaskWithRequest(request: NSURLRequest) {
    let task = session.dataTaskWithRequest(request) {
      data, response, error in
      
      if let error = error {
        print(error)
        return
      }
      
      do {
        let result = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
        
        print("Result from UPS json: \(result)")
      } catch {
        print(error)
      }
    }
    
    task.resume()
  }
  
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
      print(bodyJSON)
      return bodyJSON
      
    } catch {
      print(error)
      return nil
    }
    
  }
}







































