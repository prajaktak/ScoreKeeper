//
//  Player.swift
//  ScoreKeeper
//
//  Created by Prajakta Kulkarni on 19/09/2025.
//

import Foundation
struct Player : Identifiable{
    var id: UUID = UUID()
    
    var name:String
    var score:Int
}
