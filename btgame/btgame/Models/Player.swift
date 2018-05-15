//
//  Player.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Player {
    let displayName: String
    let id: MCPeerID
    let isAdvertiser: Bool
    
    init(displayName: String, id: MCPeerID, isAdvertiser: Bool) {
        self.displayName = displayName
        self.id = id
        self.isAdvertiser = isAdvertiser
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.displayName == rhs.displayName && lhs.id == rhs.id && lhs.isAdvertiser == rhs.isAdvertiser)
    }
}
