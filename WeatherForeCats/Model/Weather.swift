//
//  Weather.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {
  var publicTime: String?
  var title: String?
  var description: [String : String] = [:]
  var link: String?
  var forecasts: [Forecast]?
  var location: [String : String] = [:]
  var pinpointLocations: [[String : String]] = [[:]]
  var copyright: [String : AnyObject] = [:]
  
  required init?(_ map: Map) {
  }
  
  func mapping(map: Map) {
    publicTime <- map["publicTime"]
    title <- map["title"]
    description <- map["description"]
    link <- map["link"]
    forecasts <- map["forecasts"]
    location <- map["location"]
    pinpointLocations <- map["pinpointLocations"]
    copyright <- map["copyright"]
  }
}

class Forecast: Mappable {
  var dateLabel: String?
  var telop: String?
  var date: String?
  var temperature: [String : AnyObject] = [:]
  var image: [String : String] = [:]
  
  required init?(_ map: Map) {
  }
  
  func mapping(map: Map) {
    dateLabel <- map["dateLabel"]
    telop <- map["telop"]
    date <- map["date"]
    temperature <- map["temperature"]
    image <- map["image"]
  }
}
