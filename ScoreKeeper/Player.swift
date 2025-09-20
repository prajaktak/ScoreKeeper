//
//  Player.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import Foundation
import SwiftUICore

struct Player : Identifiable, Hashable{
    var id: UUID = UUID()
    
    var name:String
    var score:Int
    var color:Color = .random()
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
           lhs.name == rhs.name && lhs.score == rhs.score
       }
}
