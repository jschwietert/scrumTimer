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
  
  var updateTimer: NSTimer!
  var updateCallback: (TimerModel) -> () = {var b = $0} // TODO - ugly
  var doneCallback: () -> () = {}
  
  init(timerLength: NSTimeInterval, expireWarningPercent: Double = 0.9) {
    Duration = timerLength
    WarningDuration = timerLength * expireWarningPercent
  }
  
  func start() { startTime = currentTime }
  
  func start(handleUpdate update: (TimerModel) -> Void, handleDone done: () -> Void, updateFrequency freq: NSTimeInterval = 0.123) {
    start()
    
    updateCallback = update
    doneCallback = done
    updateTimer = NSTimer.scheduledTimerWithTimeInterval(freq, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
  }
  
  @objc func update() {
    if !expired() {
      updateCallback(self) // TODO - creating two durations
    } else {
      stop()
    }
  }
  
  func timeElapsed() -> NSTimeInterval {
    var retval: NSTimeInterval
    
    if let time = endTime {
      retval = time.timeIntervalSinceDate(startTime!)
    } else if let time = startTime {
      retval = currentTime.timeIntervalSinceDate(time)
    } else {
      retval = NSTimeInterval(0)
    }
    
    println(retval)
    
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
  
  func stop() {
    if startTime != .None {
      endTime = currentTime
    }
    
    if let timer = updateTimer {
      timer.invalidate()
      updateTimer = .None
    }
    
    doneCallback()
  }
  
  class func toString(duration: NSTimeInterval) -> String {
    var millis = (duration * 1000) % 1000
    var seconds = floor(duration % 60)
    var minutes = floor((duration / 60) % 60)
    
    return String(format: "%02.0f:%02.0f.%03.0f", minutes, seconds, millis)
  }
}