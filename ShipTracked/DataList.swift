//
//  DataType.swift
//  PlayingHand
//
//  Created by Thinh Luong on 4/16/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

protocol DataList {
  
  // MARK: Functions
  func addNewItem(item: Item, atIndex index: Int) -> Self
  func deleteItemAtIndex(index: Int) -> Self
  func moveItemFromIndex(fromIndex: Int, toIndex: Int) -> Self
  subscript(index: Int) -> Item { get }
  
  // MARK: Properties
  var numberOfItems: Int {get}
}

extension DataList {
  func addNewItem(item: Item) -> Self {
    return addNewItem(item, atIndex: 0)
  }
}

protocol Item {
  
}