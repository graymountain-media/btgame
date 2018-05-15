//
//  Timeline.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Timeline {
    var owner: Player
    var rounds: [Round]
    
    init(owner: Player) {
        self.rounds = []
        self.owner = owner
    }
}

extension Timeline: Equatable {
    static func == (lhs: Timeline, rhs: Timeline) -> Bool {
        return (lhs.owner == rhs.owner && lhs.rounds == rhs.rounds)
    }
}
