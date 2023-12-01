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
    @State private var showingStore = false

    var body: some View {
        Button(action: tryNewTag) {
            Label("Add tag", systemImage: "plus")
        }
        .sheet(isPresented: $showingStore, content: StoreView.init)

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

    func tryNewTag() {
        if dataController.newTag() == false {
            showingStore = true
        }
    }
}

struct SidebarViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        SidebarViewToolbar(showingAwards: .constant(true))
            .environmentObject(DataController.preview)
    }
}
