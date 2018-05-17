//
//  Timeline.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Timeline: Codable{
    
    var id: UUID
    var owner: Player
    var rounds: [Round]
    var possibleTopics: [String]
    
    init(owner: Player) {
        self.rounds = []
        self.owner = owner
        self.possibleTopics = []
        self.id = UUID()
    }
    
}

//extension Timeline: Equatable {
//    static func == (lhs: Timeline, rhs: Timeline) -> Bool {
//        return (lhs.owner == rhs.owner && lhs.rounds == rhs.rounds)
//    }
//}
