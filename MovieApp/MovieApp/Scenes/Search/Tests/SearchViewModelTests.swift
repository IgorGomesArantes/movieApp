//
//  SearchViewModelTests.swift
//  MovieAppTests
//
//  Created by Igor Gomes Arantes on 05/07/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import XCTest
@testable import MovieApp

class SearchViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: SearchViewModel!
    
    // MARK: - Overridden methods
    override func setUp() {
        super.setUp()
        sut = SearchViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    func testReloadSuccess() {
        // 1. given
        var onChangeResultStatus: ServiceStatus!
        sut.onChange = { status in
            onChangeResultStatus = status
        }
        
        // 2. when
        sut.reload()
        
        // 3. then
        XCTAssertEqual(onChangeResultStatus, .success)
        XCTAssertEqual(sut.resultCount, 21)
    }
    
    func testReloadError() {
        
    }
    
    func testReloadEmpty() {
        
    }
}
