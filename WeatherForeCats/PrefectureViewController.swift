//
//  PrefectureViewController.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import UIKit

class PrefectureViewController: UIViewController {
  let district = District()
  @IBOutlet private weak var tableView: UITableView!
  var dismissWindowBlock: ((String, String) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    prepareForUseTableView()
    district.loadDataFromXML()
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "onClickDoneButton:")
    navigationItem.setRightBarButtonItem(doneButton, animated: true)
    navigationItem.title = "都道府県を選択"
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func prepareForUseTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "preCell")
  }
}


// MARK: - View
extension PrefectureViewController {
  private func configureCell(cell: UITableViewCell, row: Int) {
    if let title = district.dic[row]["title"] as? String {
      cell.textLabel?.text = title
    }
    cell.textLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 14)
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
      if let dic = district.dic[indexPath.row]["cities"] as? [[String : String]] {
        cityViewController.cities = dic
      }
      cityViewController.cellTappedBlock = { [weak self] (title: String, id: String) in
        if let dismissWindowBlock = self!.dismissWindowBlock {
          dismissWindowBlock(title, id)
        }
        self?.dismissViewControllerAnimated(true, completion: nil)
      }
      navigationController?.pushViewController(cityViewController, animated: true)
    }
  }
}


// MARK: - UITableViewDataSource
extension PrefectureViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("preCell", forIndexPath: indexPath)
    configureCell(cell, row: indexPath.row)
    return cell
  }
}