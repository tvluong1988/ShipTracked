//
//  ParcelTableViewController.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/22/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class ParcelTableViewController: UITableViewController {
  // MARK: Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowParcelDetailVC",
      let parcelDetailVC = segue.destinationViewController as? ParcelDetailViewController,
      let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
      parcelDetailVC.parcel = dataSource.dataObject[indexPath.row] as? Parcel
    }
  }
  
  // MARK: Actions
  @IBAction func addButtonPressed(sender: UIBarButtonItem) {
    showTrackingNumberInputAlert()
  }
  
  // MARK: Functions
  private func requestParcelWithTrackingNumber(trackingNumber: String) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
      [unowned self] in
      self.dataSource.addParcelWithTrackingNumber(trackingNumber)
    }
  }
  private func showTrackingNumberInputAlert() {
    let alertController = UIAlertController(title: "New Parcel", message: "Please enter your tracking number", preferredStyle: .Alert)
    
    alertController.addTextFieldWithConfigurationHandler {
      trackingNumberInput in
      trackingNumberInput.placeholder = "tracking number here"
    }
    
    let okAction = UIAlertAction(title: "OK", style: .Default) {
      action in
      if let trackingNumber = alertController.textFields?.first?.text {
        self.requestParcelWithTrackingNumber(trackingNumber)
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
    
    requestParcelWithTrackingNumber(validTrackingNumberForTesting)
  }
  
  // MARK: Properties
  lazy private var dataSource: ParcelDataSource = {
    let upsService = UPSService()
    return ParcelDataSource(upsService: upsService)
  }()
  
  let validTrackingNumberForTesting = "1Z202Y36A898759591"
  let invalidTrackingNumberForTesting = "0000"
}




























