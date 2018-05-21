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
    var numberOfRounds: Int
    var returnedTimelines: [Timeline] {
        didSet{
            print("RETURNED TIMELINES: \(returnedTimelines)")
        }
    }
    var timeLimit: Int
    var players: [Player]
    var topics: [String]
    
    init(players: [Player], timelines: [Timeline], timeLimit: Int = 4) {
        self.id = UUID()
        self.numberOfRounds = players.count
        self.returnedTimelines = []
        self.timeLimit = timeLimit
        self.players = players
        self.topics = []
    }
}

extension Game: Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }
}
