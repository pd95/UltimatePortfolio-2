//
//  Bundle-AppGroup.swift
//  UltimatePortfolio
//
//  Created by Philipp on 06.04.2024.
//

import Foundation

extension Bundle {
    var appGroupID: String {
        var groupID = "group.com.yourcompany.UltimatePortfolio"
        if let bundleID = Bundle.main.bundleIdentifier,
           let groupIDPart = bundleID.firstMatch(of: /.+com.yourcompany.UltimatePortfolio/)?.output.description {
            groupID = "group.\(groupIDPart)"
        }

        return groupID
    }
}
