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
    var color:Color
}
