//
//  SourceType.swift
//  PlayingHand
//
//  Created by Thinh Luong on 4/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

protocol SourceType: UITableViewDataSource {
  // MARK: Properties
  var dataObject: DataList {get set}
  var conditionForAdding: Bool {get}
  
  // MARK: Functions
  func insertTopRowIn(tableView: UITableView)
  
  func deleteRowAtIndexPath(indexPath: NSIndexPath, fromTableView tableView: UITableView)
}

// MARK: - Methods
extension SourceType {
  
  func insertTopRowIn(tableView: UITableView) {
    tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
    tableView.reloadData()
    
  }
  
  func deleteRowAtIndexPath(indexPath: NSIndexPath, fromTableView tableView: UITableView) {
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    tableView.reloadData()
  }
  
  func addItemTo(tableView: UITableView) {
    if conditionForAdding {
      //            dataObject = dataObject.addNewItemAtIndex(0)
      insertTopRowIn(tableView)
    }
  }
}






















