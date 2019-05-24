//
//  HomeViewModelTests.swift
//  MovieAppTests
//
//  Created by Igor Gomes Arantes on 24/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import XCTest
@testable import MovieApp

class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!

    override func setUp() {
        super.setUp()
        
        sut = HomeViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
