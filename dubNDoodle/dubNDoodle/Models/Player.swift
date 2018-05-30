//
//  Player.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Player: Codable, Hashable {
    var uid: Int
    let displayName: String
    let isAdvertiser: Bool
    var isReady: Bool
    var hashValue: Int {
        return self.uid
    }
    
    init(displayName: String, id: MCPeerID, isAdvertiser: Bool) {
        self.displayName = displayName
        self.isAdvertiser = isAdvertiser
        self.uid = Int(arc4random_uniform(UInt32(1000000)))
        self.isReady = false
    }
    
    func asDict() -> [String: Player]{
        return ["player": self]
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.displayName == rhs.displayName && lhs.isAdvertiser == rhs.isAdvertiser)
    }
}
