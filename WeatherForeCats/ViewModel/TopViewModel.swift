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
      return weather.description["text"] ?? ""
    } else {
      return ""
    }
  }
  var todayWeatherImageViewPath: String {
    if let weather = weather, forecast = weather.forecasts {
      let telop = forecast[0].telop ?? "sunny"
      return createImagePath(telop)
    } else {
      return "sunny"
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
      case .Failure(let error):
        SVProgressHUD.showErrorWithStatus("通信に失敗しました")
        print("Error: \(error)")
      }
    }
  }
}
