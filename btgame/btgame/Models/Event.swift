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
    var timeline: Timeline
    var finalTimelines : [Timeline]
    
    enum Instruction: String, Codable {
        case toTopics
        case toCanvas
        case toGuess
        case endRoundReturn
        case endGame
    }
    
    init(withInstruction instruction: Instruction, timeline: Timeline = Timeline(owner: MCController.shared.playerArray[0]), timelines: [Timeline] = []) {
        self.instruction = instruction
        self.timeline = timeline
        self.finalTimelines = []
    }
}
