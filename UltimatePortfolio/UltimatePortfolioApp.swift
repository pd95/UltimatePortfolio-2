//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Philipp on 17.03.23.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
