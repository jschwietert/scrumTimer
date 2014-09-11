//
//  GroupTimer.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import Foundation

/**
  * Manage a timer. The timer increases over time.
  */
class TimerModel {
  let Duration: NSTimeInterval
  let WarningDuration: NSTimeInterval
  
  var currentTime: NSDate {
    get { return NSDate() }
  }
  
  var startTime: NSDate?
  var endTime: NSDate?
  
  init(timerLength: NSTimeInterval, expireWarningPercent: Double = 0.9) {
    Duration = timerLength
    WarningDuration = timerLength * expireWarningPercent
  }
  
  func start() { startTime = currentTime }
  
  func timeElapsed() -> NSTimeInterval {
    var retval: NSTimeInterval
    
    if let time = endTime {
      retval = time.timeIntervalSinceDate(startTime!)
    } else if let time = startTime {
      retval = currentTime.timeIntervalSinceDate(time)
    } else {
      retval = NSTimeInterval(0)
    }
    
    return retval
  }
  
  func timeRemaining() -> NSTimeInterval {
    return (Duration - timeElapsed())
  }
  
  func expiringSoon()  -> Bool {
    return timeElapsed() > WarningDuration
  }
  
  func expired() -> Bool {
    return timeElapsed() > Duration
  }
  
  func end() { endTime = currentTime }
  
  class func toString(duration: NSTimeInterval) -> String {
    var millis = (duration * 1000) % 1000
    var seconds = floor(duration % 60)
    var minutes = floor((duration / 60) % 60)
    
    return String(format: "%02.0f:%02.0f.%03.0f", minutes, seconds, millis)
  }
}