//
//  ViewController.swift
//  Scrum Timer
//
//  Created by Jonathan Schwietert on 9/7/14.
//  Copyright (c) 2014 Jonathan Schwietert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let GroupTimer = TimerModel(timerLength: NSTimeInterval(10))
  // Since the millis are updated so quickly we want to leave the perception that the view is being updated fater than
  // the user can see & that all numbers are changing - this value makes each digit of the millis readout change for each
  // update.
  let ViewUpdateFrequency = 0.123
  
  let ExpiredColor = UIColor.redColor()
  let WarningColor = UIColor.yellowColor()
  let NormalColor = UIColor.greenColor()
  
  // Recurring timer to trigger view updates.
  var timer: NSTimer!
  
  @IBOutlet weak var remainingTime: UITextView!
  
  func resetView() {
    GroupTimer.stop()
    
    remainingTime.textColor = NormalColor
  }

  func update(timer: TimerModel) {
    println("updating")
    if timer.expiringSoon() {
      remainingTime.textColor = WarningColor
    }
    
    remainingTime.text = TimerModel.toString(timer.timeElapsed())
  }
  
  func stop() {
    println("done")
    remainingTime.textColor = ExpiredColor
    remainingTime.text = TimerModel.toString(GroupTimer.Duration)
  }
  
  /** 
    * Inherited methods
    **/
  
  // Setup the view.
  override func viewDidLoad() {
    super.viewDidLoad()
    
    resetView()
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
    GroupTimer.start(handleUpdate: update, handleDone: stop, updateFrequency: ViewUpdateFrequency)
  }
}

