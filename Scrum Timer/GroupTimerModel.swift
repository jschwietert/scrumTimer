//
//  GroupTimer.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import Foundation

class GroupTimerModel {
  let MaxLength = NSTimeInterval(10)
  
  var currentTime: NSDate {
    get { return NSDate() }
  }
  
  var startTime: NSDate?
  var endTime: NSDate?
  
  init() {}
  
  func start() { startTime = currentTime }
  
  func duration() -> NSTimeInterval {
    var retval = NSTimeInterval(0)
    
    if let time = endTime {
      retval = time.timeIntervalSinceDate(startTime!)
    } else if let time = startTime {
      retval = currentTime.timeIntervalSinceDate(time)
    }
    
    return retval
  }
  
  func time(duration: NSTimeInterval) -> String {
    var millis = (duration * 1000) % 1000
    var seconds = floor(duration % 60)
    var minutes = floor((duration / 60) % 60)
    
    return String(format: "%02.0f:%02.0f.%03.0f", minutes, seconds, millis)
  }
  
  func time() -> String { return time(duration()) }
  
  func expiredAlmost() -> Bool {
    return false
  }
  
  func expired() -> Bool {
    return duration() > MaxLength
  }
  
  func end() { endTime = currentTime }
}