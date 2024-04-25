//
//  NetworkManagerTests.swift
//  DemoJSONListTests
//
//  Created by Mac on 25/04/24.
//


import XCTest
@testable import DemoJSONList

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data success")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch data with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    func testFetchDataFailure() {
        let expectation = XCTestExpectation(description: "Fetch data failure")
        
        // Using a known unreachable domain to trigger a failure
        let url = URL(string: "https://unreachable.domain")!
        
        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure but received success")
            case .failure(let error):
                // Ensure that the error is not nil and matches the expected error domain
                XCTAssertNotNil(error)
                XCTAssertEqual((error as NSError).domain, "NSURLErrorDomain")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
}



