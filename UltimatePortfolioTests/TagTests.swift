//
//  TagTests.swift
//  UltimatePortfolioTests
//
//  Created by Philipp on 06.08.23.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class TagTests: BaseTestCase {

    func test_count_countsTagsAndIssuesCorrectly() {
        let count = 10
        let issueCount = 10 * 10

        for _ in 0..<count {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<count {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), count, "Expected \(count) tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), issueCount, "Expected \(issueCount) issues.")
    }

    func test_delete_doesNotDeleteIssues() throws {
        dataController.createSampleData()

        let request = Tag.fetchRequest()
        let tags = try managedObjectContext.fetch(request)
        XCTAssertEqual(tags.count, 5, "5 tags are expected in sample data")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "50 issues are expected in sample data")

        dataController.delete(tags[0])

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4, "There should be 4 tags remaining")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should still be 50 issues!")
    }
}
