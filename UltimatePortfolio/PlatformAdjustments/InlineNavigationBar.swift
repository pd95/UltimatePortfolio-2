//
//  InlineNavigationBar.swift
//  UltimatePortfolio
//
//  Created by Philipp on 17.05.2024.
//

import SwiftUI

extension View {
    func inlineNavigationBar() -> some View {
        #if os(macOS)
        self
        #else
        self.navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
