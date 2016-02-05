//
//  CityViewController.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
  var cities: [[String : String]]?
  @IBOutlet weak var tableView: UITableView!
  var cellTappedBlock: ((String, String) -> Void)?

  override func viewDidLoad() {
    super.viewDidLoad()

    prepareForUseTableView()
    navigationItem.title = "市町村を選択"
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
    return cities?.count ?? 0
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let cellTappedBlock = cellTappedBlock, title = cities![indexPath.row]["title"], id = cities![indexPath.row]["id"] {
      cellTappedBlock(title, id)
    }
  }
}


// MARK: - UITableViewDataSource
extension CityViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    if let title = cities![indexPath.row]["title"] {
      cell.textLabel?.text = title
    }
    cell.textLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 14)
    
    return cell
  }
}
