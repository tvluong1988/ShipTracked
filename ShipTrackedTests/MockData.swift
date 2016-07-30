//
//  MockData.swift
//  ShipTracked
//
//  Created by Thinh Luong on 7/28/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

// MARK: - Functions
func createValidJSONResponse() -> [String: [String: NSDictionary]] {
  
  let address =
    ["Address": ["PostalCode" : "34639",
      "City" : "LAND O LAKES",
      "CountryCode" : "US",
      "StateProvinceCode" : "FL"
      ]
  ]
  
  let activityLocation =
    ["ActivityLocation":[address]]
  
  let activity =
    ["Activity": [activityLocation,
      activityLocation,
      activityLocation
      ]
  ]
  
  let shipmentAddresses =
    [
      ["Type": ["Code" : "01"],
        "Address": ["AddressLine": "Starting Address",
          "City": "Starting City",
          "StateProvinceCode": "IA",
          "PostalCode": "50000",
          "CountryCode": "US"
        ]
      ],
      ["Type": ["Code" : "02"],
        "Address": ["AddressLine": "Ending Address",
          "City": "Ending City",
          "StateProvinceCode": "IA",
          "PostalCode": "50000",
          "CountryCode": "US"
        ]
      ]
  ]
  
  let validJSONResponse =
    ["TrackResponse":
      ["Shipment":[
        "InquiryNumber": ["Value": "1Z202Y36A898759591"],
        "Package": activity,
        "ShipmentAddress": shipmentAddresses
        
        ]
      ]
  ]
  
  return validJSONResponse
}

func createValidDataResponse() -> NSData {
  let validJSONResponse = createValidJSONResponse()
  let data = try! NSJSONSerialization.dataWithJSONObject(validJSONResponse, options: .PrettyPrinted)
  return data
  
}

func createInvalidJSONResponse() -> [String: String] {
  let invalidJSONResponse = ["FailKey":"FailValue"]
  
  return invalidJSONResponse
}

func createInvalidDataResponse() -> NSData {
  let invalidJSONResponse = createInvalidJSONResponse()
  
  let data = try! NSJSONSerialization.dataWithJSONObject(invalidJSONResponse, options: .PrettyPrinted)
  return data
}



