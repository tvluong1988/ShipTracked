//
//  Plist.swift
//  ShipTracked
//
//  Created by Thinh Luong on 5/24/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

struct Plist {
  // MARK: Enum PlistError
  enum PlistError: ErrorType {
    case FileNotWritten
    case FileDoesNotExist
  }
  
  // MARK: Lifecycle
  init?(name: String) {
    self.name = name
    
    guard let source = sourcepath,
      let destination = destinationPath where
      fileManager.fileExistsAtPath(source) else {
        return nil
    }
    
    if !fileManager.fileExistsAtPath(destination) {
      do {
        try fileManager.copyItemAtPath(source, toPath: destination)
      } catch let error as NSError {
        print("Unable to copy file. ERROR: \(error.localizedDescription)")
        return nil
      }
    }
  }
  
  // MARK: Properties
  let name: String
  
  var sourcepath: String? {
    guard let path = mainBundle.pathForResource(name, ofType: "plist") else {
      return nil
    }
    return path
  }
  
  var destinationPath: String? {
    guard sourcepath != nil else {
      return nil
    }
    
    let directory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString
    
    return directory.stringByAppendingPathComponent("\(name).plist")
  }
  
  let mainBundle = NSBundle.mainBundle()
  let fileManager = NSFileManager.defaultManager()
}

extension Plist {
  func getValuesInPlistFile() -> NSDictionary? {
    guard fileManager.fileExistsAtPath(destinationPath!),
      let dictionary = NSDictionary(contentsOfFile: destinationPath!) else {
        return nil
    }
    
    return dictionary
  }
  
  func getMutablePlistFile() -> NSMutableDictionary? {
    guard fileManager.fileExistsAtPath(destinationPath!),
      let dictionary = NSMutableDictionary(contentsOfFile: destinationPath!) else {
        return nil
    }
    
    return dictionary
  }
  
  func addValuesToPlistFile(dictionary: NSDictionary) throws {
    guard fileManager.fileExistsAtPath(destinationPath!) else {
      throw PlistError.FileDoesNotExist
    }
    
    guard dictionary.writeToFile(destinationPath!, atomically: false) else {
      throw PlistError.FileNotWritten
    }
  }
}





























