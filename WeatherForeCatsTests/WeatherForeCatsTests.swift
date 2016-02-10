//
//  WeatherForeCatsTests.swift
//  WeatherForeCatsTests
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import XCTest
@testable import WeatherForeCats

class WeatherForeCatsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let name1 = createImagePath("曇のち晴")
        XCTAssertEqual(name1, "sunnycloud")
        let image1 = UIImage(named: name1)
        XCTAssertNotNil(image1)
        let name2 = createImagePath("曇時々雨")
        XCTAssertEqual(name2, "raincloud")
        let image2 = UIImage(named: name2)
        XCTAssertNotNil(image2)
        let name3 = createImagePath("雪のち雨")
        XCTAssertEqual(name3, "sunny")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
