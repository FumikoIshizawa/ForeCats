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
  @IBOutlet weak var todayWeatherImageView: UIImageView!
  @IBOutlet weak var todayWeatherTitleLabel: UILabel!
  @IBOutlet weak var todayWeatherDetailLabel: UILabel!
  @IBOutlet weak var topNavigationItem: UINavigationItem!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let configButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "onClickConfigButton:")
    topNavigationItem.setRightBarButtonItem(configButton, animated: true)
    
    topViewModel.prepareForeUseView()
    
    //test
    let district = District()
    district.loadDataFromXML()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}


extension ViewController {
  internal func onClickConfigButton(sender: UIButton) {
    let storyBoard = UIStoryboard(name: "PrefectureViewController", bundle: nil)
    if let prefectureViewController = storyBoard.instantiateInitialViewController() as? PrefectureViewController {
      self.presentViewController(prefectureViewController, animated: true, completion: nil)
    } 
  }
}

