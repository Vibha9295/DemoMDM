//
//  ViewControllerTests.swift
//  DemoJSONListTests
//
//  Created by Mac on 25/04/24.
//

import XCTest
@testable import DemoJSONList


class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testFetchDataInvalidURL() {
        // Set up the view controller
        let tableView = UITableView()
        viewController.tableView = tableView

        // Ensure that the posts array is initially empty
        XCTAssertTrue(viewController.posts.isEmpty)

        // Simulate fetching data with an invalid URL
        viewController.fetchData()

        // Ensure that the posts array remains empty after fetching data with an invalid URL
        XCTAssertTrue(viewController.posts.isEmpty)
    }
}
