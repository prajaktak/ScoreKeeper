//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import Foundation
struct  Scoreboard{
    var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    
    var state: GameState = .setup
    var doesHighestScoreWin = true
    var roundNumber: Int = 1
    
    var winners: [Player] {
        guard state == .gameOver else { return [] }
        var winningScore = 0
        if doesHighestScoreWin {
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
            
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
        return players.filter { player in
                   player.score == winningScore
               }
    }
    
    mutating func resetScores(to newValue: Int){
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
    mutating func resetRoundNumber(){
        roundNumber = 1
    }
    mutating func increamentRound() {
        roundNumber += 1
    }
    func isGameOver(maxNumberOfRounds: Int)->Bool{
        return roundNumber > maxNumberOfRounds
    }
    
}
