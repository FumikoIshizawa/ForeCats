//
//  TopViewModel.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import APIKit
import UIKit

class TopViewModel: NSObject {

  func prepareForeUseView() {
    let request = GetDailyForecastsRequest()
    Session.sendRequest(request) { result in
      switch result {
      case .Success(let weather):
        print(weather)
      case .Failure(let error):
        print("error: \(error)")
      }
    }
  }
}
