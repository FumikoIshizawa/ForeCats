//
//  WeatherRequest.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import APIKit
import Foundation
import ObjectMapper

public protocol WeatherRequestType: RequestType {
  
}


extension WeatherRequestType where Self.Response: Mappable {
  var baseURL: NSURL {
    return NSURL(string: "http://weather.livedoor.com/forecast/webservice/json/")!
  }
  
  func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Self.Response? {
    guard let dictionary = object as? [String : AnyObject] else {
      return nil
    }
    
    let mapper = Mapper<Response>()
    guard let object = mapper.map(dictionary) else {
      return nil
    }
    
    return object
  }
}


struct GetDailyForecastsRequest: WeatherRequestType {
  typealias Response = Weather
  
  var path: String {
    return "v1"
  }
  
  var method: HTTPMethod {
    return .GET
  }
  
  var parameters: [String : AnyObject] {
    return ["city" : "400040"]
  }
}
