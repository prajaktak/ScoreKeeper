//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreBoard  = Scoreboard()
    @State private var startScore: Int = 0
    @State private var isHighScorewin: Bool = true
    @State private var maxRounds: Int = 1
    @State private var isGameOver: Bool = false
    //    @State private var players: [Player] = [
    //        Player(name: "Elisha", score: 0,color: .random()),
    //        Player(name: "Andre", score: 0,color: .random()),
    //        Player(name: "Jasmine", score: 0,color: .random()),
    //    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            SettingsView(startScore: $startScore, isHighScoreWin: $isHighScorewin, maxRounds: $maxRounds)
                .disabled(scoreBoard.state != .setup)
            NavigationStack {
                List {
                    Text("Round \(scoreBoard.roundNumber)/\(maxRounds)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .opacity(scoreBoard.state != .gameOver ? 1.0 : 0)
                    HStack {
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        Spacer()
                        Text("Score")
                            .opacity(scoreBoard.state == .setup ? 0 : 1.0)
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    ForEach($scoreBoard.players) {$player in
                        HStack {
                            HStack {
                                if scoreBoard.winners.contains(player) {
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(Color.yellow)
                                }
                                TextField("Name", text: $player.name)
                                    .disabled(scoreBoard.state != .setup)
                            }
                            Text("\(player.score)")
                                .opacity(scoreBoard.state == .setup ? 0 : 1.0)
                            Stepper("\(player.score)") {
                                if scoreBoard.state == .playing {
                                    if !scoreBoard.isGameOver(maxRounds: maxRounds) {
                                        if player.score < 20 {
                                            player.score += 1
                                        }
                                    }
                                }
                            } onDecrement: {
                                if scoreBoard.state == .playing {
                                    if !scoreBoard.isGameOver(maxRounds: maxRounds) {
                                        if player.score > 0 {
                                            player.score -= 1
                                        }
                                    }
                                }
                            }
                            .disabled(scoreBoard.isGameOver(maxRounds: maxRounds))
                            .opacity(scoreBoard.state == .setup ? 0 : 1.0)
                            .labelsHidden()
                        }
                        .listRowBackground(player.color)
                        .foregroundStyle(player.color.adaptedTextColor())
                    }
                    .onMove(perform: move)
                }
// .toolbar { EditButton() }
                .padding(.vertical)
            }
            Button("Add player",systemImage: "plus.circle") {
                scoreBoard.players.append(Player(name: "New Player", score: 0))
            }
            .opacity(scoreBoard.state == .setup ? 1.0 : 0)
            HStack {
                Spacer()
                switch scoreBoard.state {
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreBoard.state = .playing
                        scoreBoard.resetScores(to: startScore)
                    }
                case .playing:
                    HStack {
                        Button("End Game", systemImage: "stop.fill") {
                            scoreBoard.state = .gameOver
                        }
                        Spacer()
                        Button("Next Round", systemImage: "forward.end.circle.fill") {
                            scoreBoard.increamentRound()
                            if scoreBoard.isGameOver(maxRounds: maxRounds) {
                                scoreBoard.state = .gameOver
                                isGameOver = true
                            }
                        }
                    }
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.counterclockwise") {
                        scoreBoard.resetRoundNumber()
                        scoreBoard.state = .setup
                    }
                    .alert(isPresented: $isGameOver) {
                        let title = Text("Game Over")
                        let message =  Text("Well played! Game over.")
                        return Alert(title:title, message:message, dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.blue)
        }
        .padding()
    }
    func move(from source: IndexSet, to destination: Int) {
        scoreBoard.players.move(fromOffsets: source, toOffset: destination)
    }
}

public extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
    func luminance() -> Double {
        // Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)
        // Extract RGB values
        var redVal:CGFloat = 0
        var greenVal:CGFloat = 0
        var blueVal:CGFloat = 0
        uiColor.getRed(&redVal, green: &greenVal, blue: &blueVal, alpha: nil)
        // Compute luminance.
        return 0.2126 * Double(redVal) + 0.7152 * Double(greenVal) + 0.0722 * Double(blueVal)
    }
    func isLight() -> Bool {
        return luminance() > 0.5
    }
    func adaptedTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}

#Preview {
    ContentView()
}
