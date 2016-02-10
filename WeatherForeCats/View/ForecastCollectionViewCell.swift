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
      minTempLabel.text = "最低気温 \(minTemp)℃"
    } else {
      minTempLabel.text = "最低気温"
    }
    
    if let maxTemp = data.temperature["max"]!["celsius"] as? String {
      maxTempLabel.text = "最高気温 \(maxTemp)℃"
    } else {
      maxTempLabel.text = "最高気温"
    }
  }
}
