//
//  ViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit
import GoogleMaps

class ParcelDetailViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var trackingNumberLabel: UILabel!
  @IBOutlet weak var mapView: UIView!
  
  // MARK: Lifecycle
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    self.title = parcel?.trackingNumber
    
    loadGoogleMapView()
  }
  
  // MARK: Properties
  var parcel: Parcel?
  
}

private extension ParcelDetailViewController {
  func addAddressToMapView(address: String) {
  }
  
  func loadGoogleMapView() {
    let defaultLat = -33.86
    let defaultLong = 151.20
    let defaultZoom: Float = 6.0
    
    let camera = GMSCameraPosition.cameraWithLatitude(defaultLat, longitude: defaultLong, zoom: defaultZoom)
    let googleMapView = GMSMapView.mapWithFrame(mapView.frame, camera: camera)
    
    self.view = googleMapView
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: defaultLat, longitude: defaultLong)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = googleMapView
    
  }
}















