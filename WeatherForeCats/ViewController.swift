//
//  ViewController.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import APIKit
import UIKit

class ViewController: UIViewController {
  let topViewModel = TopViewModel()
  var city: String = "新潟"
  var id: String = "150010"
  @IBOutlet weak var todayWeatherImageView: UIImageView!
  @IBOutlet weak var todayWeatherTitleLabel: UILabel!
  @IBOutlet weak var todayWeatherDetailLabel: UILabel!
  @IBOutlet weak var topNavigationItem: UINavigationItem!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let configButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "onClickConfigButton:")
    topNavigationItem.setRightBarButtonItem(configButton, animated: true)
    
    let successBlock = { [weak self] in
      self!.updateLabels()
    }
    topViewModel.prepareForeUse(id, block: successBlock)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}


// MARK: - View 
extension ViewController {
  func updateLabels() {
    todayWeatherTitleLabel.text = topViewModel.todayWeatherTitle
    todayWeatherDetailLabel.text = topViewModel.todayWeatherDetail
  }
}


// MARK: - Action
extension ViewController {
  internal func onClickConfigButton(sender: UIButton) {
    let storyBoard = UIStoryboard(name: "PrefectureViewController", bundle: nil)
    if let prefectureViewController = storyBoard.instantiateInitialViewController() as? PrefectureViewController {
      prefectureViewController.dismissWindowBlock = { [weak self] (title: String, id: String) in
        self!.city = title
        self!.id = id
        self!.topViewModel.updateData(id)
      }
      let navController = UINavigationController(rootViewController: prefectureViewController)
      self.presentViewController(navController, animated: true, completion: nil)
    } 
  }
}

