//
//  ViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit
import MapKit

class ParcelDetailViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var trackingNumberLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: Lifecycle
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.title = parcel?.trackingNumber
    
    if let parcel = parcel {
      
      for address in parcel.addressesToAnnotate {
        if AddressPlacemarkSession.sharedSession.addressBook.keys.contains(address.getFullAddress()) {
          mapView.addAnnotation(MKPlacemark(placemark: AddressPlacemarkSession.sharedSession.addressBook[address.getFullAddress()]!))
          print("added placemark to mapview")
        } else {
          addAddressToMapView(address.getFullAddress())
          print("geocode request to get placemark")
        }
      }
    }
  }
  
  // MARK: Properties
  var parcel: Parcel?
  let geocoder = CLGeocoder()
  
}

extension ParcelDetailViewController {
  func addAddressToMapView(address: String) {
    
    geocoder.geocodeAddressString(address) {
      placemarks, error in
      
      if let error = error {
        print(error)
      } else {
        
        if let placemark = placemarks?.first {
          
          AddressPlacemarkSession.sharedSession.addressBook[address] = placemark
          
          dispatch_async(dispatch_get_main_queue()) {
            [unowned self] in
            
            self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
          }
        }
      }
    }
  }
}















