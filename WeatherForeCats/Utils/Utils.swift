//
//  File.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/07.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import SystemConfiguration

func CheckReachability(hostName: String) -> Bool {
  let ability = SCNetworkReachabilityCreateWithName(nil, hostName)
  var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
  
  guard let reachAbility = ability else {
    return false
  }
  
  if !SCNetworkReachabilityGetFlags(reachAbility, &flags) {
    return false
  }
  
  let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
  let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
  
  return (isReachable && !needsConnection)
}

func createImagePath(weather: String) -> String {
  let imagePaths = ["sunny", "sunnycloud", "sunnyrain", "rain", "raincloud", "snow", "snowcloud", "cloud"]
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
  
  imagePath = imagePaths.indexOf(imagePath) == nil ? "sunny" : imagePath
  
  return imagePath
}

