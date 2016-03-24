//
//  WeiBoUITests.swift
//  WeiBoUITests
//
//  Created by Konan on 16/3/8.
//  Copyright © 2016年 Konan. All rights reserved.
//

import XCTest

class WeiBoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        let app = XCUIApplication()
//        app.navigationBars["首页"].buttons["navigationbar pop"].tap()
//        app.tabBars.buttons["\\U6761\\U5f62\\U7801"].tap()
//        app.buttons["\\U6211\\U7684\\U540d\\U7247"].tap()
//        app.navigationBars["\\U6211\\U7684\\U540d\\U7247"].buttons["\\U4e8c\\U7ef4\\U7801\\U626b\\U63cf"].tap()
//        app.navigationBars["\\U4e8c\\U7ef4\\U7801\\U626b\\U63cf"].buttons["\\U5173\\U95ed"].tap()
        
    }
    
}
