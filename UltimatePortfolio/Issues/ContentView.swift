//
//  ContentView.swift
//  UltimatePortfolio
//
//  Created by Philipp on 17.03.23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel
    @SceneStorage("lastReviewDate") private var lastReviewRequestDate = Date.distantPast

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $viewModel.filterText,
            tokens: $viewModel.filterTokens,
            suggestedTokens: .constant(viewModel.suggestedFilterTokens),
            prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
    }

    func askForReview() {
        if viewModel.shouldRequestReview && lastReviewRequestDate.addingTimeInterval(7*60*60*24) < Date.now {
            requestReview()
            lastReviewRequestDate = Date.now
        }
    }
}

extension Date: RawRepresentable {
    public init(rawValue value: Int) {
        self.init(timeIntervalSince1970: Double(value))
    }

    public var rawValue: Int {
        Int(timeIntervalSince1970)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataController: .preview)
    }
}
