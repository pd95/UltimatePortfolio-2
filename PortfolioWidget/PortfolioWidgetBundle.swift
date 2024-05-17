//
//  PortfolioWidgetBundle.swift
//  PortfolioWidget
//
//  Created by Philipp on 06.04.2024.
//

import WidgetKit
import SwiftUI

@main
struct PortfolioWidgetBundle: WidgetBundle {
    var body: some Widget {
        SimplePortfolioWidget()
        ComplexPortfolioWidget()
    }
}
