//
//  Timeline.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Timeline {
    var id: UUID
    var rounds: [Round]
    
    init() {
        self.rounds = []
        self.id = UUID()
    }
}

extension Timeline: Equatable {
    static func == (lhs: Timeline, rhs: Timeline) -> Bool {
        return (lhs.id == rhs.id)
    }
}
