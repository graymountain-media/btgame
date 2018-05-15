//
//  Player.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import MultipeerConnectivity

struct Player {
    let displayName: String
    let id: MCPeerID
    let isAdvertiser: Bool
    let timelineID: UUID
    
    init(displayName: String, id: MCPeerID, isAdvertiser: Bool, timelineID: UUID) {
        self.displayName = displayName
        self.id = id
        self.isAdvertiser = isAdvertiser
        self.timelineID = timelineID
    }
}
