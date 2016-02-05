//
//  CityViewController.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var cityNavigationItem: UINavigationItem!

  override func viewDidLoad() {
    super.viewDidLoad()

    prepareForUseTableView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func prepareForUseTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}


// MARK: - UITableViewDelegate
extension CityViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44
  }
}


// MARK: - UITableViewDataSource
extension CityViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    return cell
  }
}
