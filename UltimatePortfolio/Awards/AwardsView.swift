//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Philipp on 11.04.23.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject private var dataController: DataController
    @Environment(\.dismiss) private var dismiss

    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(color(for: award))
                        }
                        .buttonStyle(.borderless)
                        .accessibilityLabel(label(for: award))
                        .accessibilityHint(award.description)
                    }
                }
            }
            .navigationTitle("Awards")
            #if !os(watchOS)
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
            #endif
        }
        .macFrame(minWidth: 600, maxHeight: 500)
        .alert(awardTitle, isPresented: $showingAwardDetails) {
        } message: {
            Text(selectedAward.description)
        }
    }

    var awardTitle: LocalizedStringKey {
        if dataController.hasEarned(award: selectedAward) {
            return "Unlocked: \(selectedAward.name)"
        } else {
            return "Locked"
        }
    }

    func color(for award: Award) -> Color {
        dataController.hasEarned(award: award) ? Color(award.color) : .secondary.opacity(0.5)
    }

    func label(for award: Award) -> LocalizedStringKey {
        dataController.hasEarned(award: award) ? "Unlocked: \(award.name)" : "Locked"
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
            .environmentObject(DataController.preview)
    }
}
