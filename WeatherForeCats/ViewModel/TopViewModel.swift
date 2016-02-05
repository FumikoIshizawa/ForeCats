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
  var todayWeatherTitle: String = "指定されていません"
  var todayWeatherDetail: String = "指定されていません"

  func prepareForeUseView() {
    //requestDailyForecasts()
  }
}


// MARK: - Request

extension TopViewModel {
  private func requestDailyForecasts() {
    let request = GetDailyForecastsRequest()
    Session.sendRequest(request) { result in
      switch result {
      case .Success(let weather):
        self.todayWeatherTitle = weather.title ?? "指定されていません"
        self.todayWeatherDetail = weather.description["text"] ?? "指定されていません"
        print(weather.description)
      case .Failure(let error):
        print("error: \(error)")
      }
    }
  }
}
