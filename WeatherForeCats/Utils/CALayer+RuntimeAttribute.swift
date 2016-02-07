
//
//  File.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/07.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import UIKit

extension CALayer {
  var borderUIColor: UIColor {
    set {
      self.borderColor = newValue.CGColor
    }
    
    get {
      return UIColor(CGColor: self.borderColor!)
    }
  }
}
