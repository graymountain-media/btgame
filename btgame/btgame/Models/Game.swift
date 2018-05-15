//
//  Game.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Game {
    let id: UUID
    let numRounds: Int
    var timeLines: [Timeline]
    var timeLimit: TimeInterval
    var players: [Player]
    var topics: [String]
    
    init(players: [Player], timeLines: [Timeline], timeLimit: TimeInterval = 15) {
        self.id = UUID()
        self.numRounds = players.count
        self.timeLines = timeLines
        self.timeLimit = timeLimit
        self.players = players
        self.topics = []
    }
}