//
//  ParcelTableViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/22/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class ParcelTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
    dataSource.tableView = tableView
    
    navigationItem.leftBarButtonItem = editButtonItem()
    
    title = "Parcel List"
    
    dataSource.addParcelWithTrackingNumber(validTrackingNumberForTesting)
    dataSource.addParcelWithTrackingNumber(invalidTrackingNumberForTesting)
    
    tableView.reloadData()
  }
  
  // MARK: Properties
  private var dataSource = ParcelDataSource()
  let validTrackingNumberForTesting = "1Z202Y36A898759591"
  let invalidTrackingNumberForTesting = "0000"
}




























