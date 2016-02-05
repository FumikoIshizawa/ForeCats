//
//  PrefectureViewController.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import UIKit

class PrefectureViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var prefectureNavigationItem: UINavigationItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    prepareForUseTableView()
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "onClickDoneButton:")
    prefectureNavigationItem.setRightBarButtonItem(doneButton, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func prepareForUseTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}


// MARK: - Action
extension PrefectureViewController {
  internal func onClickDoneButton(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}


// MARK: - UITableViewDelegate
extension PrefectureViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 51
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44.0
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let storyBoard = UIStoryboard(name: "CityViewController", bundle: nil)
    if let cityViewController = storyBoard.instantiateInitialViewController() as? CityViewController {
      self.presentViewController(cityViewController, animated: true, completion: nil)
    }
  }
}


// MARK: - UITableViewDataSource
extension PrefectureViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    return cell
  }
}