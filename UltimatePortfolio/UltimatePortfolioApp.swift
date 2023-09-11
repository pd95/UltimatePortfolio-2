//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Philipp on 17.03.23.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView(dataController: dataController)
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .onChange(of: scenePhase) { phase in
                if phase != .active {
                    dataController.save()
                }
            }
        }
    }
}
