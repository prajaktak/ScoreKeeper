//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [String] = ["Elisa", "Juan", "Pedro"]
    @State private var scores: [Int] = [0,0,0]
    var body: some View {
        VStack {
            ForEach(0..<players.count, id:\.description){index in
                TextField("Name", text: $players[index])
                Stepper("\(scores[index])", value: $scores[index])
            }
            Button("Add player",systemImage: "plus.circle"){
                players.append("")
                scores.append(0)
            }
        }
        .padding()
        Spacer()
    }
}

#Preview {
    ContentView()
}
