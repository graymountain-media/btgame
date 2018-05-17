//
//  GameCommands.swift
//  btgame
//
//  Created by Jake Gray on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

enum Event: String, Codable {
    case StartGame = "StartGame",
    toTopics = "toTopics",
    EndGame = "EndGame"
}
