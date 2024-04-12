//
//  iOsCodingAssigmentTests.swift
//  iOsCodingAssigmentTests
//
//  Created by Gregori Farias  on 11/4/24.
//

import XCTest
import UIKit
import Combine
@testable import iOsCodingAssigment



class CountryListViewModelTests: XCTestCase {
    
    var viewModel: CountryListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CountryListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadCountries() {
        let expectation = XCTestExpectation(description: "Load countries")
        
        viewModel.loadCountries()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(self.viewModel.countries.isEmpty, "Countries should be loaded")
            XCTAssertFalse(self.viewModel.filteredCountries.isEmpty, "Filtered countries should be loaded")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    
    func testFilterCountries() {
            viewModel.countries = [
                Country(name: "Albania", region: "AS", code: "AF", capital: "Tirana"),
                Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa")
            ]
            
            viewModel.filterCountries(by: "Albania")
            XCTAssertEqual(viewModel.filteredCountries.count, 1, "Filtered countries count should be 1")
            
            viewModel.filterCountries(by: "Ott")
            XCTAssertEqual(viewModel.filteredCountries.count, 1, "Filtered countries count should be 1")
        }
    }
}
