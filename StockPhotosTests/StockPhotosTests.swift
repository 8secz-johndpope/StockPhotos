//
//  StockPhotosTests.swift
//  StockPhotosTests
//
//  Created by ONUR KILIC on 2.08.2019.
//  Copyright © 2019 Onur Kilic. All rights reserved.
//

import XCTest
@testable import StockPhotos

class StockPhotosTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDatastore() {
        let expectation = XCTestExpectation(description: "Fetch photo data from shutterstock")
        ListViewModel().fetchInitialPhotos() { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testDataStoreClearFunc() {
        let listViewModel = ListViewModel()
        listViewModel.clear()
        let count = listViewModel.getDataCount()
        XCTAssertEqual(count, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
