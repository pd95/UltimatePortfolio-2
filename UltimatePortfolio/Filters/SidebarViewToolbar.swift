//
//  SidebarViewToolbar.swift
//  UltimatePortfolio
//
//  Created by Philipp on 28.05.23.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject private var dataController: DataController

    @Binding var showingAwards: Bool

    var body: some View {
        Button(action: dataController.newTag) {
            Label("Add tag", systemImage: "plus")
        }

        Button {
            showingAwards.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }

        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("ADD SAMPLES", systemImage: "flame")
        }
        #endif
    }
}

struct SidebarViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarViewToolbar(showingAwards: .constant(true))
            .environmentObject(DataController.preview)
    }
}
