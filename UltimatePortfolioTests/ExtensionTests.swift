//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by Philipp on 12.08.23.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class ExtensionTests: BaseTestCase {
    func testIssueTitleUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.title = "Example issue"
        XCTAssertEqual(issue.issueTitle, "Example issue", "Changing title should also change issueTitle.")

        issue.issueTitle = "Updated issue"
        XCTAssertEqual(issue.title, "Updated issue", "Changing issueTitle should also change title.")
    }

    func testIssueContentUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.content = "Example issue"
        XCTAssertEqual(issue.issueContent, "Example issue", "Changing content should also change issueContent.")

        issue.issueContent = "Updated issue"
        XCTAssertEqual(issue.content, "Updated issue", "Changing issueContent should also change content.")
    }

    func testIssueCreationDateUnwrap() {
        // Given
        let issue = Issue(context: managedObjectContext)
        let testDate = Date.now

        // When
        issue.creationDate = testDate

        // Then
        XCTAssertEqual(issue.issueCreationDate, testDate, "Changing creationDate should also change issueCreationDate.")
    }

    func testIssueTagsUnwrap() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        XCTAssertEqual(issue.issueTags.count, 0, "A new issue should have 0 tags.")

        issue.addToTags(tag)
        XCTAssertEqual(issue.issueTags.count, 1, "Adding 1 tag to an issue should result in issueTags having count 1.")
    }

    func testIssueTagsList() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        tag.name = "My Tag"
        issue.addToTags(tag)

        XCTAssertEqual(issue.issueTagsList, "My Tag", "Adding 1 tag to an issue should make issueTagsList be My Tag.")
    }

    func testIssueSortingIsStable() {
        let issue1 = Issue(context: managedObjectContext)
        issue1.title = "B Issue"
        issue1.creationDate = .now

        let issue2 = Issue(context: managedObjectContext)
        issue2.title = "B Issue"
        issue2.creationDate = .now.addingTimeInterval(1)

        let issue3 = Issue(context: managedObjectContext)
        issue3.title = "A Issue"
        issue3.creationDate = .now.addingTimeInterval(100)

        let allIssues = [issue1, issue2, issue3]
        let sorted = allIssues.sorted()

        XCTAssertEqual([issue3, issue1, issue2], sorted, "Sorting issue arrays should use name then creation date.")
    }

    func testTagIDUnwrap() {
        let tag = Tag(context: managedObjectContext)

        XCTAssertNotEqual(tag.tagID, tag.tagID, "nil id will generate new UUID in every access to tagID.")

        let newID = UUID()
        tag.id = newID
        XCTAssertEqual(tag.tagID, newID, "Changing id should also update tagID.")
    }

    func testTagNameUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.name = "Example tag"
        XCTAssertEqual(tag.tagName, "Example tag", "Changing name should also change tagName.")
    }

    func testTagActiveIssues() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        XCTAssertEqual(tag.tagActiveIssues.count, 0, "A new tag should have 0 active issues.")

        issue.addToTags(tag)
        XCTAssertEqual(tag.tagActiveIssues.count, 1, "Adding 1 tag to an issue makes activeIssues count 1 for the tag.")

        issue.completed = true
        XCTAssertEqual(tag.tagActiveIssues.count, 0, "Completing issue should make activeIssues count 0 for the tag.")
    }

    func testTagSortingIsStable() {
        let tag1 = Tag(context: managedObjectContext)
        tag1.id = UUID()
        tag1.name = "B Tag"

        let tag2 = Tag(context: managedObjectContext)
        tag2.id = UUID(uuidString: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF")
        tag2.name = "B Tag"

        let tag3 = Tag(context: managedObjectContext)
        tag3.id = UUID()
        tag3.name = "A Tag"

        let allTags = [tag1, tag2, tag3]
        let sorted = allTags.sorted()

        XCTAssertEqual([tag3, tag1, tag2], sorted, "Sorting issue arrays should use name then uuidString.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode("Awards.json", as: [Award].self)
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }

    func testBundleDecodingSimpleString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableString.json", as: String.self)

        XCTAssertEqual(data, "Never ask a starfish for directions.", "The string must match DecodableString.json")
    }

    func testBundleDecodingSimpleDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableDictionary.json", as: [String: Int].self)

        let expected = ["One": 1, "Two": 2, "Three": 3]
        XCTAssertEqual(data, expected, "The data must match content of DecodableDictionary.json")
    }
}
