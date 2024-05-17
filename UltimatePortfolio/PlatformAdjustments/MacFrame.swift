//
//  MacFrame.swift
//  UltimatePortfolio
//
//  Created by Philipp on 17.05.2024.
//

import SwiftUI

extension View {
    func macFrame(
        minWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil
    ) -> some View {
        #if os(macOS)
        self.frame(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight)
        #else
        self
        #endif
    }
}
