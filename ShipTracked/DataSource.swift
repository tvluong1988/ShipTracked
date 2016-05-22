//
//  DataSource.swift
//  PlayingHand
//
//  Created by Thinh Luong on 4/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import UIKit

class DataSource: NSObject, SourceType {
  
  // MARK: Lifecycle
  init<A: DataList>(dataObject: A) {
    self.dataObject = dataObject
  }
  
  // MARK: Properties
  var dataObject: DataList
  var conditionForAdding: Bool {
    return false
  }
  
}

// MARK: - UITableViewDataSource
extension DataSource: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataObject.numberOfItems
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    fatalError("This method must be overriden.")
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      dataObject = dataObject.deleteItemAtIndex(indexPath.row)
      deleteRowAtIndexPath(indexPath, fromTableView: tableView)
    }
  }
  
  func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    dataObject = dataObject.moveItemFromIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
  }
}






















