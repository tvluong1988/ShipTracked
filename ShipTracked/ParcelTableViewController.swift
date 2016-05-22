//
//  ParcelTableViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/22/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class ParcelTableViewController: UITableViewController {
  
  // MARK: Actions
  @IBAction func addButtonPressed(sender: UIBarButtonItem) {
    showTrackingNumberInputAlert()
  }
  
  // MARK: Functions
  private func showTrackingNumberInputAlert() {
    let alertController = UIAlertController(title: "New Parcel", message: "Please enter your tracking number", preferredStyle: .Alert)
    
    alertController.addTextFieldWithConfigurationHandler {
      trackingNumberInput in
      trackingNumberInput.placeholder = "tracking number here"
    }
    
    let okAction = UIAlertAction(title: "OK", style: .Default) {
      action in
      if let trackingNumber = alertController.textFields?.first?.text {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
          [unowned self] in
          self.dataSource.addParcelWithTrackingNumber(trackingNumber)
        }
      }
    }
    
    alertController.addAction(okAction)
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  // MARK: Lifecycle
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




























