//
//  PlayerController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class PlayerController {
    
    static func create(displayName: String, id: MCPeerID, isAdvertiser: Bool, timelineID: UUID) -> Player {
        let player = Player(displayName: displayName, id: id, isAdvertiser: isAdvertiser, timelineID: timelineID)
        return player
    }
    
    static func delete(player: Player, game: Game) {
        if let playerIndex = game.players.index(of: player) {
            game.players.remove(at: playerIndex)
        }
    }
}
