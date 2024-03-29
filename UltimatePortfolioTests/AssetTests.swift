//
//  AssetTests.swift
//  UltimatePortfolioTests
//
//  Created by Philipp on 04.06.23.
//

import XCTest
@testable import UltimatePortfolio

final class AssetTests: XCTestCase {

    func test_namedColors_exist() {
        let allColors = ["Dark Blue", "Dark Gray", "Gold", "Green", "Light Blue", "Midnight",
                         "Orange", "Pink", "Purple", "Red", "Teal"]

        for color in allColors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }

    func test_allAwards_loadsSuccessfully() {
        XCTAssertTrue(Award.allAwards.isEmpty == false, "Failed to load awards from JSON.")
    }
}
