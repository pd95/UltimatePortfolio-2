//
//  TagsMenuView.swift
//  UltimatePortfolio
//
//  Created by Philipp on 28.05.23.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject private var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        #if os(watchOS)
        LabeledContent("Tags", value: issue.issueTagsList)
        #else
        Menu {
            ForEach(issue.issueTags) { tag in
                Button {
                    issue.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }

            let otherTags = dataController.missingTags(from: issue)

            if otherTags.isEmpty == false {
                Divider()

                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button(tag.tagName) {
                            issue.addToTags(tag)
                        }
                    }
                }
            }
        } label: {
            Text(issue.issueTagsList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(nil, value: issue.issueTagsList)
        }
        #endif
    }
}

struct TagsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TagsMenuView(issue: .example)
            .environmentObject(DataController.preview)
    }
}
