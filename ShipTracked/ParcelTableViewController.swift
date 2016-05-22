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
    
    navigationItem.leftBarButtonItem = editButtonItem()
    
    title = "Parcel List"
  }
  
  // MARK: Properties
  let dataSource = ParcelDataSource()
}




























