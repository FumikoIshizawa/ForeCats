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
  var successBlock: (Void -> Void)?

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
    var request = GetDailyForecastsRequest()
    request.cityId = id
    Session.sendRequest(request) { result in
      switch result {
      case .Success(let weather):
        self.todayWeatherTitle = weather.title ?? "指定されていません"
        self.todayWeatherDetail = weather.description["text"] ?? "指定されていません"
        if let successBlock = self.successBlock {
          successBlock()
        }
        print(weather.description)
      case .Failure(let error):
        print("error: \(error)")
      }
    }
  }
}
