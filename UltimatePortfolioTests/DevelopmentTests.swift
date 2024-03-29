//
//  DevelopmentTests.swift
//  UltimatePortfolioTests
//
//  Created by Philipp on 12.08.23.
//

import XCTest
import CoreData
@testable import UltimatePortfolio

final class DevelopmentTests: BaseTestCase {
    func test_createSampleData_generatesExpectedData() {
        dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should be 50 sample issues.")
    }

    func test_deleteAll_clearsEverything() {
        dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "deleteAll() should leave 0 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "deleteAll() should leave 0 sample issues.")
    }

    func test_deleteAll_clearsNewlyInsertedItems() {
        let newIssue = Issue(context: managedObjectContext)
        let newTag = Tag(context: managedObjectContext)

        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "deleteAll() should leave 0 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "deleteAll() should leave 0 sample issues.")
    }

    func test_exampleTag_hasNoIssues() {
        let tag = Tag.example

        XCTAssertEqual(tag.issues?.count, 0, "The example tag should have 0 issues.")
    }

    func test_exampleIssue_hasHighPriority() throws {
        let issue = Issue.example

        XCTAssertEqual(issue.priority, 2, "The example issue should be high priority.")
    }
}
