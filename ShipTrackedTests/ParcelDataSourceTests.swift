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
    
    // MARK: Properties
    let mockURLSession = MockURLSession()
    let mockUPSService = UPSService(session: mockURLSession)
    var mockTableView: UITableView?
    
    var parcelDataSource: ParcelDataSource!
    
    let trackingNumber = "1Z202Y36A898759591"
    let invalidTrackingNumber = "0000"
    
    // MARK: Tests
    describe("given a ParcelDataSource") {
      
      
      beforeEach() {
        mockTableView = UITableView()
        parcelDataSource = ParcelDataSource(upsService: mockUPSService)
        parcelDataSource.tableView = mockTableView
      }
      
      afterEach() {
        mockTableView = nil
        parcelDataSource.tableView = nil
        parcelDataSource = nil
        
      }
      
      context("when addParcelWithTrackingNumber is called with a valid tracking number") {
        it("then it should add a new parcel with tracking number validated to the parcelDataSource dataObject list") {
          let invalidDataResponse = self.createValidDataResponse()
          mockURLSession.nextData = invalidDataResponse
          
          parcelDataSource.addParcelWithTrackingNumber(trackingNumber)
          
          expect(parcelDataSource.dataObject.count).toEventually(equal(1))
          
          if let parcel = parcelDataSource.dataObject.first as? Parcel {
            expect(parcel.isTrackingNumberValid).toEventually(beTrue())
          }
        }
      }
      
      context("when addParcelWithTrackingNumber is called with an invalid tracking number") {
        it("then it should add a new parcel with tracking number invalidated to the parcelDataSource dataObject list") {
          let validDataResponse = self.createInvalidDataResponse()
          mockURLSession.nextData = validDataResponse
          
          parcelDataSource.addParcelWithTrackingNumber(invalidTrackingNumber)
          
          expect(parcelDataSource.dataObject.count).toEventually(equal(1))
          
          if let parcel = parcelDataSource.dataObject.first as? Parcel {
            expect(parcel.isTrackingNumberValid).toEventually(beFalse())
          }
        }
      }
    }
  }
}

// MARK: - Private functions
private extension ParcelDataSourceSpec {
  func createValidDataResponse() -> NSData {
    
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
    
    let data = try! NSJSONSerialization.dataWithJSONObject(validJSONResponse, options: .PrettyPrinted)
    return data
    
  }
  
  func createInvalidDataResponse() -> NSData {
    let invalidJSONResponse = ["FailKey":"FailValue"]
    
    let data = try! NSJSONSerialization.dataWithJSONObject(invalidJSONResponse, options: .PrettyPrinted)
    return data
  }
}























