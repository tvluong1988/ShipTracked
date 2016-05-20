//
//  ParcelManager.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class ParcelManager {
  
  // MARK: Functions
  func addParcelWithTrackingNumber(trackingNumber: String) {
    trackingNumberRequests.append(trackingNumber)
    trackingNumberRequestCount += 1
    
    upsService.requestParcelInfoWithTrackingNumber(trackingNumber)
  }
  
  // MARK: Lifecycle
  
  // MARK: Properties
  var parcelCount: Int {
    return self.parcels.count
  }
  
  private var parcels = [Parcel]()
  private var trackingNumberRequests = [String]()
  private var trackingNumberRequestCount: Int = 0
  
  private lazy var upsService: UPSService = {
    let service = UPSService()
    service.delegate = self
    return service
  }()
}

extension ParcelManager: UPSServiceDelegate {
  @objc func didReceiveData(data: AnyObject) {
    
    if let json = JSON(rawValue: data),
      let trackingNumber = json["TrackResponse"]["Shipment"]["InquiryNumber"]["Value"].string {
      print("Did receive data: \(json)")
      var matchTrackingNumber = false
      
      for trackingNumberRequest in trackingNumberRequests {
        if trackingNumber == trackingNumberRequest {
          matchTrackingNumber = true
        }
      }
      
      if matchTrackingNumber {
        if let parcel = extractParcelFromJSON(json) {
          parcels.append(parcel)
          print(parcel)
        }
      }
    } else {
      print("Raw data: \(data)")
    }
    
    trackingNumberRequestCount -= 1
    
    if trackingNumberRequestCount == 0 {
      for trackingNumberRequest in trackingNumberRequests {
        let parcel = Parcel(trackingNumber: trackingNumberRequest, isTrackingNumberValid: false)
        parcels.append(parcel)
      }
      
      trackingNumberRequests.removeAll()
    }
  }
  
  private func extractActivityAddressesFromJSON(json: JSON) -> [Address]? {
    
    guard let activities = json["TrackResponse"]["Shipment"]["Package"]["Activity"].array else {
      return nil
    }
    
    var activityAddresses = [Address]()
    
    activitiesLoop: for activity in activities {
      
      guard let activityLocation = activity["ActivityLocation"].dictionary,
        let address = activityLocation["Address"]?.dictionary else {
          continue activitiesLoop
      }
      
      // Guard against addresses without City or State field.
      guard let city = address["City"]?.string,
        let state = address["StateProvinceCode"]?.string else {
          continue activitiesLoop
      }
      
      let addressLine = address["AddressLine"]?.string
      let postalCode = address["PostalCode"]?.string
      let country = address["CountryCode"]?.string
      
      let activityAddress = Address(addressLine: addressLine, city: city, state: state, postalCode: postalCode, country: country)
      
      // Loop through current activityAddresses to prevent adding repeated activityAddress.
      var matchedPreviousActivityAddress = false
      
      activityAddressesLoop: for address in activityAddresses {
        if activityAddress.city == address.city
          && activityAddress.state == address.state {
          matchedPreviousActivityAddress = true
          break activityAddressesLoop
        }
      }
      
      if !matchedPreviousActivityAddress {
        activityAddresses.append(activityAddress)
      }
      
    }
    
    return activityAddresses
  }
  
  private func extractParcelFromJSON(json: JSON) -> Parcel? {
    
    if let trackingNumber = json["TrackResponse"]["Shipment"]["InquiryNumber"]["Value"].string,
      let shipmentAddresses = json["TrackResponse"]["Shipment"]["ShipmentAddress"].array {
      
      var startingAddress = Address()
      var endingAddress = Address()
      
      shipmentLoop: for shipmentAddress in shipmentAddresses {
        if let shipmentCode = shipmentAddress["Type"]["Code"].string {
          
          guard let addressJSON = shipmentAddress["Address"].dictionary else {
            continue shipmentLoop
          }
          
          let addressLine = addressJSON["AddressLine"]?.string
          let city = addressJSON["City"]?.string
          let state = addressJSON["StateProvinceCode"]?.string
          let postalCode = addressJSON["PostalCode"]?.string
          let country = addressJSON["CountryCode"]?.string
          
          let address = Address(addressLine: addressLine, city: city, state: state, postalCode: postalCode, country: country)
          
          
          switch shipmentCode {
          case "01": // Shipper's Code
            startingAddress = address
          case "02": // Ship-to Code
            endingAddress = address
          default:
            break
          }
        }
      }
      
      var parcel = Parcel(trackingNumber: trackingNumber, isTrackingNumberValid: true)
      parcel.startingAddress = startingAddress
      parcel.endingAddress = endingAddress
      
      if let activityAddresses = extractActivityAddressesFromJSON(json) {
        parcel.activityAddresses = activityAddresses
      }
      
      return parcel
    }
    
    return nil
  }
}






















