//
//  AwardTests.swift
//  UltimatePortfolioTests
//
//  Created by Philipp on 06.08.23.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class AwardTests: BaseTestCase {
    let awards = Award.allAwards

    func test_awardID_matchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }

    func test_hasEarned_hasNoAwardsUnlockedForNewUser() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should not have award \(award.name)")
        }
    }

    func test_hasEarned_unlocksAwardsWhenCreatingIssues() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            var issues = [Issue]()

            for _ in 0..<value {
                let issue = Issue(context: managedObjectContext)
                issues.append(issue)
            }

            let matches = awards.filter { award in
                award.criterion == "issues" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Adding \(value) issues should unlock \(count + 1) awards")
            dataController.deleteAll()
        }
    }

    func test_hasEarned_unlocksAwardsWhenClosingIssues() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            var issues = [Issue]()

            for _ in 0..<value {
                let issue = Issue(context: managedObjectContext)
                issue.completed = true
                issues.append(issue)
            }

            let matches = awards.filter { award in
                award.criterion == "closed" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Completing \(value) issues should unlock \(count + 1) awards")
            dataController.deleteAll()
        }
    }
}
