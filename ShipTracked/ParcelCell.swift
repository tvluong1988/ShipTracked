//
//  ParcelCell.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/22/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class ParcelCell: UITableViewCell {
  // MARK: Functions
  func fillWith(parcel: Parcel) {
    textLabel?.text = parcel.trackingNumber
    detailTextLabel?.text = parcel.isTrackingNumberValid.description
  }
}
