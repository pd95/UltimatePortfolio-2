//
//  IssueViewToolbar.swift
//  UltimatePortfolio
//
//  Created by Philipp on 28.05.23.
//

import CoreHaptics
import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject private var dataController: DataController
    @ObservedObject var issue: Issue

    @State private var engine = try? CHHapticEngine()

    var openCloseButtonText: LocalizedStringKey {
        issue.completed ? "Re-open Issue" : "Close Issue"
    }

    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.string = issue.title
            } label: {
                Label("Copy Issue Title", systemImage: "doc.on.doc")
            }

            Button(action: toggleCompleted) {
                Label(openCloseButtonText, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
//            // iOS 17 way to trigger haptic feedback
//            .sensoryFeedback(trigger: issue.completed) { _, newValue in
//                if newValue {
//                    .success
//                } else {
//                    nil
//                }
//            }

            Divider()

            Section("Tags") {
                TagsMenuView(issue: issue)
            }
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }

    func toggleCompleted() {
        issue.completed.toggle()
        dataController.save()

        // Before iOS 17, we use `UINotificationFeedbackGenerator` for haptic feedback or CoreHaptics
        if issue.completed {
            // UINotificationFeedbackGenerator().notificationOccurred(.success)

            // Play a custom haptic using CoreHaptics engine
            do {
                try engine?.start()

                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)

                let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
                let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)

                let parameter = CHHapticParameterCurve(
                    parameterID: .hapticIntensityControl,
                    controlPoints: [start, end],
                    relativeTime: 0
                )

                let event1 = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [intensity, sharpness],
                    relativeTime: 0
                )

                let event2 = CHHapticEvent(
                    eventType: .hapticContinuous,
                    parameters: [sharpness, intensity],
                    relativeTime: 0.125,
                    duration: 1
                )

                let pattern = try CHHapticPattern(events: [event1, event2], parameterCurves: [parameter])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Playing haptics didn't work, but that's ok")
            }
        }
    }
}

struct IssueViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        IssueViewToolbar(issue: .example)
            .environmentObject(DataController.preview)
    }
}
