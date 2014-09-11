//
//  GroupTimerModelTest.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import UIKit
import XCTest

class TimerModelTest: XCTestCase {
  var gt: TimerModel!

  override func setUp() {
    super.setUp()
    gt = TimerModel(timerLength: NSTimeInterval(2 * 60))
  }
  
//  override func tearDown() {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//    super.tearDown()
//  }
//  
//  func testPerformanceExample() {
//    // This is an example of a performance test case.
//    self.measureBlock() {
//      // Put the code you want to measure the time of here.
//    }
//  }
  
  func testStartTimer() {
    gt.start()
    var now = NSDate()
    XCTAssert(now.compare(gt.startTime!) == NSComparisonResult.OrderedDescending)
  }
  
  func testTimeElapsedAfterStarted() {
    gt.start()
    XCTAssert(gt.timeElapsed() > 0)
  }

  func testTimeZero() {
    XCTAssertEqual("00:00.000", TimerModel.toString(NSTimeInterval(0)))
  }
  
  func testTimeOneHalfSecond() {
    XCTAssertEqual("00:00.510", TimerModel.toString(NSTimeInterval(0.51)))
  }
  
  func testThirtySeconds() {
    XCTAssertEqual("00:30.000", TimerModel.toString(NSTimeInterval(30.0)))
  }
  
  func testThirtyOneSeconds() {
    XCTAssertEqual("00:31.000", TimerModel.toString(NSTimeInterval(31.0)))
  }
  
  func testSixtySeconds() {
    XCTAssertEqual("01:00.000", TimerModel.toString(NSTimeInterval(60.0)))
  }
  
  func testSixtyOneSeconds() {
    XCTAssertEqual("01:01.000", TimerModel.toString(NSTimeInterval(61.0)))
  }
  
  func testSixtyOneAndFractionSeconds() {
    XCTAssertEqual("01:01.213", TimerModel.toString(NSTimeInterval(61.213)))
  }
  
  func testExpiringSoon() {
    gt.startTime = NSDate().dateByAddingTimeInterval(NSTimeInterval(-1 * gt.WarningDuration))
    
    XCTAssert(gt.expiringSoon())
  }
  
  func testExpiration() {
    gt.startTime = NSDate().dateByAddingTimeInterval(NSTimeInterval(-1 * gt.Duration))
    
    XCTAssert(gt.expired())
  }
}