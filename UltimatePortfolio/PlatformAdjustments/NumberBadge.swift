//
//  NumberBadge.swift
//  UltimatePortfolio
//
//  Created by Philipp on 17.05.2024.
//

import SwiftUI

extension View {
    func numberBadge(_ number: Int) -> some View {
        #if os(watchOS)
        self
        #else
        self.badge(number)
        #endif
    }
}
