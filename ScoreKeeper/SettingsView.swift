//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var startingScore: Int
    @Binding var doesHighestScoreWin: Bool
    @Binding var numberOfRounds: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Rules")
                .font(.headline)
            Divider()
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest Score Wins")
                    .tag(true)
                Text("Lowest Score Wins")
                    .tag(false)
            }
            Picker("Starting points", selection: $startingScore){
                Text("0 starting points")
                    .tag(0)
                Text("10 starting points")
                    .tag(10)
                Text("20 starting points")
                    .tag(20)
            }
            Picker("Number of rounds", selection: $numberOfRounds){
                Text("5 Rounds")
                    .tag(5)
                Text("4 Rounds")
                    .tag(4)
                Text("3 Rounds")
                    .tag(3)
                Text("2 Rounds")
                    .tag(2)
                Text("1 Round")
                    .tag(1)
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
}

#Preview {
    @Previewable @State var startingScore: Int = 10
    @Previewable @State var doesHighestScoreWin: Bool = true
    @Previewable @State var numberOfRounds: Int = 5
    SettingsView(startingScore: $startingScore,doesHighestScoreWin: $doesHighestScoreWin,numberOfRounds: $numberOfRounds)
}
