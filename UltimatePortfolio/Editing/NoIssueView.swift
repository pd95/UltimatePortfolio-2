//
//  NoIssueView.swift
//  UltimatePortfolio
//
//  Created by Philipp on 28.03.23.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject private var dataController: DataController

    var body: some View {
        Text("No Issue Selected")
            .font(.title)
            .foregroundColor(.secondary)

        Button("New Issue", action: dataController.newIssue)
    }
}

struct NoIssueView_Previews: PreviewProvider {
    static var previews: some View {
        NoIssueView()
    }
}
