//
//  ViewController.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let GroupTimer = GroupTimerModel()
  // Since the millis are updated so quickly we want to leave the perception that the view is being updated fater than
  // the user can see & that all numbers are changing - this value makes each digit of the millis readout change for each
  // update.
  let ViewUpdateFrequency = 0.123
  
  let ExpiredColor = UIColor.redColor()
  let WarningColor = UIColor.yellowColor()
  let NormalColor = UIColor.greenColor()
  
  var timer: NSTimer!
  
  @IBOutlet weak var remainingTime: UITextView!
  
  func resetView() {
    stop()
    remainingTime.textColor = NormalColor
  }

  func update() {
    var newTime = GroupTimer.time()
    
    if let t = timer { if GroupTimer.expired() {
      stop()
      newTime = GroupTimer.time(GroupTimer.MaxLength)
      remainingTime.textColor = UIColor.redColor()
      }}
    
    remainingTime.text = newTime
  }
  
  func stop() {
    if let t = timer {
      t.invalidate()
      timer = nil
    }
  }
  
  /** 
    * Inherited methods
    **/
  
  // Setup the view.
  override func viewDidLoad() {
    super.viewDidLoad()
    
    resetView()
    update()
  }

  // Dispose of any resources that can be recreated.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Setup table view for the sake of learning
  func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  // Source the table data
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")

    cell.textLabel!.text = "Row #\(indexPath.row)"
    cell.detailTextLabel!.text = "Subtitle #\(indexPath.row)"
    
    println(indexPath.row)
    
    return cell
  }

  /** 
    * Actions
    **/
  @IBAction func startTapped(sender: AnyObject) {
    resetView()
    GroupTimer.start()
    
    timer = NSTimer.scheduledTimerWithTimeInterval(ViewUpdateFrequency, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
  }
}

