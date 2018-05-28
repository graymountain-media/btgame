//
//  Event.swift
//  btgame
//
//  Created by Jake Gray on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Event: Codable {
    var instruction: Instruction
    var round: Round
    var topics: [String]
    var finalTimelines : [Timeline]
    var fromPlayer: Int
    
    enum Instruction: String, Codable {
        case toTopics
        case toCanvas
        case toGuess
        case endRoundReturn
        case endGame
    }
    
    init(withInstruction instruction: Instruction, round: Round = Round(owner: MCController.shared.playerArray[0], image: nil, guess: nil, isImage: false), topics: [String] = [], timelines: [Timeline] = [], fromPlayer: Int = 0) {
        self.instruction = instruction
        self.round = round
        self.topics = topics
        self.finalTimelines = timelines
        self.fromPlayer = fromPlayer
    }
}
