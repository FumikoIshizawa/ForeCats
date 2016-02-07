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
  var weather: Weather?
  var successBlock: (Void -> Void)?
  var todayWeatherTitle: String {
    if let weather = weather {
      return weather.title ?? "指定されていません"
    } else {
      return "指定されていません"
    }
  }
  var todayWeatherDetail: String {
    if let weather = weather {
      return weather.description["text"] ?? "指定されていません"
    } else {
      return "指定されていません"
    }
  }
  
  func loadForecastOfCity(row: Int) -> Forecast? {
    if let weather = weather {
      return weather.forecasts![row]
    } else {
      return nil
    }
  }

  func prepareForeUse(id: String, block: (Void -> Void)) {
    successBlock = block
    requestDailyForecasts(id)
  }
  
  func updateData(id: String) {
    requestDailyForecasts(id)
  }
}


// MARK: - Request
extension TopViewModel {
  private func requestDailyForecasts(id: String) {
    SVProgressHUD.show()
    var request = GetDailyForecastsRequest()
    request.cityId = id
    Session.sendRequest(request) { result in
      switch result {
      case .Success(let weather):
        self.weather = weather
        if let successBlock = self.successBlock {
          successBlock()
        }
        print(weather.description)
      case .Failure(let error):
        SVProgressHUD.showErrorWithStatus("通信に失敗しました: \(error)")
      }
    }
  }
}
