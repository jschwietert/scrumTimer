//
//  GroupTimerModelTest.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import UIKit
import XCTest

class GroupTimerModelTest: XCTestCase {
  var gt: GroupTimerModel!

  override func setUp() {
    super.setUp()
    gt = GroupTimerModel(max: NSTimeInterval(2 * 60))
  }
  
  func testStartTimer() {
    gt.start()
    var now = NSDate()
    XCTAssert(now.compare(gt.startTime!) == NSComparisonResult.OrderedDescending)
  }
  
  func testDurationAfterStarted() {
    gt.start()
    XCTAssert(gt.duration() > 0)
  }

  func testTimeZero() {
    XCTAssertEqual("00:00.000", gt.time(NSTimeInterval(0)))
  }
  
  func testTimeOneHalfSecond() {
    XCTAssertEqual("00:00.510", gt.time(NSTimeInterval(0.51)))
  }
  
  func testThirtySeconds() {
    XCTAssertEqual("00:30.000", gt.time(NSTimeInterval(30.0)))
  }
  
  func testThirtyOneSeconds() {
    XCTAssertEqual("00:31.000", gt.time(NSTimeInterval(31.0)))
  }
  
  func testSixtySeconds() {
    XCTAssertEqual("01:00.000", gt.time(NSTimeInterval(60.0)))
  }
  
  func testSixtyOneSeconds() {
    XCTAssertEqual("01:01.000", gt.time(NSTimeInterval(61.0)))
  }
  
  func testSixtyOneAndFractionSeconds() {
    XCTAssertEqual("01:01.213", gt.time(NSTimeInterval(61.213)))
  }
  
  func testAlmostExpired() {
    gt.startTime = NSDate().dateByAddingTimeInterval(NSTimeInterval(-1 * gt.AlmostMax))
    
    XCTAssert(gt.expiringSoon())
  }
  
  func testExpiration() {
    gt.startTime = NSDate().dateByAddingTimeInterval(NSTimeInterval(-1 * gt.MaxLength))
    
    XCTAssert(gt.expired())
  }
}