//
//  ParcelList.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/22/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct ParcelList {
  
  // MARK: Lifecycle
  init() {
    self.parcels = [Parcel]()
  }
  init(parcels: [Parcel]) {
    self.parcels = parcels
  }
  
  // MARK: Properties
  let parcels: [Parcel]
  
}

private extension ParcelList {
  func insertParcel(parcel: Parcel, atIndex index: Int) -> ParcelList {
    var mutableParcels = parcels
    mutableParcels.insert(parcel, atIndex: index)
    
    return ParcelList(parcels: mutableParcels)
  }
}

extension ParcelList: DataList {
  
  var count: Int {
    return parcels.count
  }
  
  subscript(index: Int) -> Item {
    return parcels[index]
  }
  
  var first: Item? {
    var parcel: Parcel?
    
    if parcels.count > 0 {
      parcel = parcels[0]
    }
    
    return parcel
  }
  
  func addNewItem(item: Item, atIndex index: Int) -> ParcelList {
    let item = item as! Parcel
    return insertParcel(item, atIndex: index)
  }
  
  func deleteItemAtIndex(index: Int) -> ParcelList {
    var mutableParcels = parcels
    mutableParcels.removeAtIndex(index)
    
    return ParcelList(parcels: mutableParcels)
  }
  
  func moveItemFromIndex(fromIndex: Int, toIndex: Int) -> ParcelList {
    return deleteItemAtIndex(fromIndex).insertParcel(parcels[fromIndex], atIndex: toIndex)
  }
}




























