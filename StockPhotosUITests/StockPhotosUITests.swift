//
//  StockPhotosUITests.swift
//  StockPhotosUITests
//
//  Created by ONUR KILIC on 2.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import XCTest

class StockPhotosUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        
    }

    func testCellClick() {
        app.collectionViews.cells.element(boundBy:0).tap()
        XCTAssert(app.buttons["StockPhotos"].exists)
    }

}
