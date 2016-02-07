//
//  ForecastCollectionViewCell.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/06.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var forecastImageView: UIImageView!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var weatherLabel: UILabel!
  @IBOutlet private weak var minTempLabel: UILabel!
  @IBOutlet private weak var maxTempLabel: UILabel!
  
  func setLabelContent(data: Forecast) {
    if let date = data.date {
      dateLabel.text = date
    }
    
    if let weather = data.telop {
      weatherLabel.text = weather
      let imagePath = createImagePath(weather)
      forecastImageView.image = UIImage(named: imagePath)
    }
    
    if let minTemp = data.temperature["min"]!["celsius"] as? String {
      minTempLabel.text = "最低気温\(minTemp)℃"
    } else {
      minTempLabel.text = ""
    }
    
    if let maxTemp = data.temperature["max"]!["celsius"] as? String {
      maxTempLabel.text = "最高気温\(maxTemp)℃"
    } else {
      maxTempLabel.text = ""
    }
  }
  
  private func createImagePath(weather: String) -> String {
    var imagePath = String()
    if weather.rangeOfString("晴") != nil {
      imagePath += "sunny"
    }
    
    if weather.rangeOfString("雨") != nil {
      imagePath += "rain"
    }
    
    if weather.rangeOfString("雪") != nil {
      imagePath += "snow"
    }
    
    if weather.rangeOfString("曇") != nil {
      imagePath += "cloud"
    }
    
    return imagePath
  }
}
