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

  override func viewDidLoad() {
    super.viewDidLoad()
    topViewModel.prepareForeUseView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  

}

