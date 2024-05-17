//
//  SidebarView.swift
//  UltimatePortfolio
//
//  Created by Philipp on 22.03.23.
//

import SwiftUI

struct SidebarView: View {
    @StateObject private var viewModel: ViewModel

    let smartFilters: [Filter] = [.all, .recent]

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters, content: SmartFilterRow.init)
            }

            Section("Tags") {
                ForEach(viewModel.tagFilters) { filter in
                    UserFilterRow(filter: filter, rename: viewModel.rename, delete: viewModel.delete)
                }
                .onDelete(perform: viewModel.delete)
            }
        }
        .macFrame(minWidth: 220)
        .toolbar {
            SidebarViewToolbar(showingAwards: $viewModel.showingAwards)
        }
        .alert("Rename tag", isPresented: $viewModel.renamingTag) {
            Button("OK", action: viewModel.completeRename)
            Button("Cancel", role: .cancel) {}
            TextField("New name", text: $viewModel.tagName)
        }
        .sheet(isPresented: $viewModel.showingAwards, content: AwardsView.init)
        .navigationTitle("Filters")
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(dataController: .preview)
    }
}
