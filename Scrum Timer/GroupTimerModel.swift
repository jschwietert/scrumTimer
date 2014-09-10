//
//  GroupTimer.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import Foundation

/**
  * Manage a timer for a group of people. The timer increases over time.
  */
class GroupTimerModel {
  let AlmostMax: NSTimeInterval
  let MaxLength: NSTimeInterval
  
  var currentTime: NSDate {
    get { return NSDate() }
  }
  
  var startTime: NSDate?
  var endTime: NSDate?
  
  init(max: NSTimeInterval) {
    MaxLength = max
    AlmostMax = max * 0.90
  }
  
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
  
  func expiringSoon(duration: NSTimeInterval)  -> Bool {
    return duration > AlmostMax
  }
  func expiringSoon() -> Bool { return expiringSoon(duration()) }
  
  func expired(duration: NSTimeInterval) -> Bool {
    return duration > MaxLength
  }
  func expired() -> Bool { return expired(duration()) }
  
  func end() { endTime = currentTime }
}