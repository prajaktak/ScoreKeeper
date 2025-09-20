//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {
    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "Elisha", score: 0),
            Player(name: "Andre", score: 5)
        ])
        scoreboard.resetScores(to: newValue)
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }
    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
                Player(name: "Khalil", score: 4)
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        let testWinners: [Player] = [scoreboard.players[1], scoreboard.players[2]]
//        var winningScore = Int.min
//        for player in scoreboard.players {
//            winningScore = max(player.score, winningScore)
//        }
//        let testWinners = scoreboard.players.filter { player in
//                   player.score == winningScore
//               }
        #expect(winners == testWinners)
    }
    @Test("Lowest score wins")
    func lowestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
                Player(name: "Khalil", score: 0)
            ],
            state: .gameOver,
            doesHighestScoreWin: false
        )
        let winners = scoreboard.winners
        let testWinners: [Player] = [scoreboard.players[0], scoreboard.players[2]]
//        var winningScore = Int.max
//        for player in scoreboard.players {
//            winningScore = min(player.score, winningScore)
//        }
//        let testWinners = scoreboard.players.filter { player in
//                   player.score == winningScore
//               }
        #expect(winners == testWinners)
    }
    @Test("Increament Round")
    func incrementRound() {
        var scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
                Player(name: "Khalil", score: 0)
            ],
            state: .playing,
            doesHighestScoreWin: false,
            roundNumber: 1
        )
        let oldRoundNumber = scoreboard.roundNumber
        scoreboard.increamentRound()
        let newRoundNumber = scoreboard.roundNumber
        #expect(oldRoundNumber + 1 == newRoundNumber)
    }
    @Test("Game Over", arguments: [1, 2, 3, 4, 5])
    func isGameOver(numberOfRounds: Int) {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
                Player(name: "Khalil", score: 0)
            ],
            state: .playing,
            doesHighestScoreWin: false,
            roundNumber: 6
        )
        let isOver = scoreboard.isGameOver(maxRounds: numberOfRounds)
        #expect(isOver != (scoreboard.roundNumber <= numberOfRounds))
    }
    @Test("Reset Round number")
    func resetRoundNumber() {
        var scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
                Player(name: "Khalil", score: 0)
            ],
            state: .playing,
            doesHighestScoreWin: false,
            roundNumber: 6
        )
        scoreboard.resetRoundNumber()
        #expect(scoreboard.roundNumber == 1)
    }
}
