//
//  ContentViewModel.swift
//  UltimatePortfolio
//
//  Created by Philipp on 15.10.23.
//

import Foundation

extension ContentView {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        var dataController: DataController

        var shouldRequestReview: Bool {
            dataController.count(for: Tag.fetchRequest()) >= 5
        }

        init(dataController: DataController) {
            self.dataController = dataController
        }

        subscript<Value>(dynamicMember keypath: KeyPath<DataController, Value>) -> Value {
            dataController[keyPath: keypath]
        }

        subscript<Value>(dynamicMember keypath: ReferenceWritableKeyPath<DataController, Value>) -> Value {
            get { dataController[keyPath: keypath] }
            set { dataController[keyPath: keypath] = newValue }
        }

        func delete(_ offsets: IndexSet) {
            let issues = dataController.issuesForSelectedFilter()

            for offset in offsets {
                let item = issues[offset]
                dataController.delete(item)
            }
        }

        func newIssue() {
            dataController.newIssue()
        }
    }
}
