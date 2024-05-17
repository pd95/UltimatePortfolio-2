//
//  IssueRowWatch.swift
//  UPAWatch Watch App
//
//  Created by Philipp on 17.05.2024.
//

import SwiftUI

struct IssueRowWatch: View {
    @EnvironmentObject private var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        NavigationLink(value: issue) {
            VStack(alignment: .leading) {
                Text(issue.issueTitle)
                    .font(.headline)
                    .lineLimit(1)

                Text(issue.issueCreationDate.formatted(date: .numeric, time: .omitted))
                    .font(.subheadline)
            }
            .foregroundStyle(issue.completed ? .secondary : .primary)
        }
    }
}

#Preview {
    IssueRowWatch(issue: .example)
}
