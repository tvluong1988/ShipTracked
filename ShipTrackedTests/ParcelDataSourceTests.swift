//
//  ParcelManagerTests.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/19/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Quick
import Nimble
@testable import ShipTracked

class ParcelDataSourceSpec: QuickSpec {
  
  override func spec() {
    let mockURLSession = MockURLSession()
    let mockUPSService = UPSService(session: mockURLSession)
    var parcelDataSource: ParcelDataSource!
    
    let trackingNumber = "1Z202Y36A898759591"
    
    describe("given a ParcelDataSource") {
      beforeEach() {
        parcelDataSource = ParcelDataSource(upsService: mockUPSService)
      }
      
      context("when addParcelWithTrackingNumber is called") {
        it("then it should ") {
          let validDataResponse = self.createValidDataResponse()
          mockURLSession.nextData = validDataResponse
          
          parcelDataSource.addParcelWithTrackingNumber(trackingNumber)
          
          expect(parcelDataSource.dataObject.count).to(equal(0))
          
          if let parcel = parcelDataSource.dataObject.first as? Parcel {
            expect(parcel.isTrackingNumberValid).to(beTrue())
          }
        }
      }
    }
  }
}

private extension ParcelDataSourceSpec {
  func createValidDataResponse() -> NSData {
    
    let address =
      ["Address":
        ["PostalCode" : "34639",
          "City" : "LAND O LAKES",
          "CountryCode" : "US",
          "StateProvinceCode" : "FL"
        ]
    ]
    
    let activityLocation =
      ["ActivityLocation":
        [address
        ]
    ]
    
    let activity =
      ["Activity":
        [activityLocation,
          activityLocation,
          activityLocation
        ]
    ]
    
    let validJSONResponse =
      ["TrackResponse":
        ["Shipment":[
          "Inquiry":
            ["Value": "1Z202Y36A898759591"]
          ,
          "Package": activity
          
          ]
        ]
    ]
    
    let data = try! NSJSONSerialization.dataWithJSONObject(validJSONResponse, options: .PrettyPrinted)
    return data
    
  }
}























