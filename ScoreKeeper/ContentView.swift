//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    var body: some View {
        VStack (alignment: .leading){
            Text("Score Keeper")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            Grid{
                GridRow{
                    Text("Player")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                }
                .font(.title3)
                .fontWeight(.bold)
                
                ForEach($players){$player in
                    GridRow {
                        
                        TextField("Name", text: $player.name)
                        Text("\(player.score)")
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                    }
                }
            }
            .padding(.vertical)
            
            Button("Add player",systemImage: "plus.circle"){
                players.append(Player(name: "New Player", score: 0))
            }
            
            Spacer()
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
