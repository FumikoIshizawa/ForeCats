//
//  District.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import Foundation

class District: NSObject {
  var dic: [[String : AnyObject]] = []
  var cities: [AnyObject]? = nil
  var prefName: String?
  
  func loadDataFromXML() {
    if let filePath = NSBundle.mainBundle().pathForResource("primary_area", ofType: "xml") {
        do {
          let data = try String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
          if let data = data.dataUsingEncoding(NSUTF8StringEncoding) {
            let parser = NSXMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            if let cities = cities, prefName = prefName {
              dic.append(["title": prefName, "cities": cities])
            }
          }
        }
        catch let error as NSError {
          print(error.localizedDescription)
        }
    }
  }
}

extension District: NSXMLParserDelegate {
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    if elementName == "pref" {
      if let cities = cities, prefName = prefName {
        dic.append(["title": prefName, "cities": cities])
      }
      prefName = attributeDict["title"]
      cities = []
    } else if elementName == "city" {
      if let title = attributeDict["title"], id = attributeDict["id"] {
        cities?.append(["title": title, "id": id])
      }
    }
  }
}
