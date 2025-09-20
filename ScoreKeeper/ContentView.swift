//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreBoard  = Scoreboard()
    @State private var startingScore: Int = 0
    @State private var doesHighestScoreWin: Bool = true
    @State private var numberOfRounds: Int = 1
    @State private var isGameOver: Bool = false
    //    @State private var players: [Player] = [
    //        Player(name: "Elisha", score: 0,color: .random()),
    //        Player(name: "Andre", score: 0,color: .random()),
    //        Player(name: "Jasmine", score: 0,color: .random()),
    //    ]
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Score Keeper")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            SettingsView(startingScore: $startingScore, doesHighestScoreWin: $doesHighestScoreWin, numberOfRounds: $numberOfRounds)
                .disabled(scoreBoard.state != .setup)
            NavigationStack{
                List{
                    Text("Round \(scoreBoard.roundNumber)/\(numberOfRounds)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .opacity(scoreBoard.state != .gameOver ? 1.0 : 0)
                    HStack{
                        Text("Player")
                            .gridColumnAlignment(.leading)
                        Spacer()
                        Text("Score")
                            .opacity(scoreBoard.state == .setup ? 0 : 1.0)
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    ForEach($scoreBoard.players){$player in
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
                            //                            Stepper("\(player.score)", value: $player.score, in:0...20, step: 1)
                            
                            //or you cancreate stepper like this
                            Stepper("\(player.score)"){
                                if scoreBoard.state == .playing && !scoreBoard.isGameOver(maxNumberOfRounds: numberOfRounds){
                                    if player.score < 20{
                                        player.score += 1
                                    }
                                }
                                
                                
                            } onDecrement: {
                                if scoreBoard.state == .playing && !scoreBoard.isGameOver(maxNumberOfRounds: numberOfRounds){
                                    if player.score > 0{
                                        player.score -= 1
                                    }
                                }
                            }
                            .disabled(scoreBoard.isGameOver(maxNumberOfRounds: numberOfRounds))
                            .opacity(scoreBoard.state == .setup ? 0 : 1.0)
                            .labelsHidden()
                            //or you can create stepper without limits like this
                            //                            Stepper("\(player.score)", value: $player.score)
                            
                        }
                        .listRowBackground(player.color)
                        .foregroundStyle(player.color.adaptedTextColor())
                    }
                    .onMove(perform: move)
                }
                //.toolbar { EditButton() }
                .padding(.vertical)
            }
            Button("Add player",systemImage: "plus.circle"){
                scoreBoard.players.append(Player(name: "New Player", score: 0))
            }
            .opacity(scoreBoard.state == .setup ? 1.0 : 0)
            
            HStack{
                Spacer()
                switch scoreBoard.state {
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreBoard.state = .playing
                        scoreBoard.resetScores(to: startingScore)
                    }
                case .playing:
                    HStack{
                        Button("End Game", systemImage: "stop.fill") {
                            scoreBoard.state = .gameOver
                        }
                        Spacer()
                        Button("Next Round", systemImage: "forward.end.circle.fill") {
                            scoreBoard.increamentRound()
                            if scoreBoard.isGameOver(maxNumberOfRounds: numberOfRounds) {
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
                        Alert(title:Text("Game Over"), message: Text("Well played! Game over."), dismissButton: .default(Text("OK")))
                    }
                    //            default:
                    //                EmptyView()
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
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Compute luminance.
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
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
