//
//  DetailView.swift
//  UltimatePortfolio
//
//  Created by Philipp on 22.03.23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var dataController: DataController

    var body: some View {
        VStack {
            if let issue = dataController.selectedIssue {
                IssueView(issue: issue)
            } else {
                NoIssueView()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(DataController.preview)
    }
}
