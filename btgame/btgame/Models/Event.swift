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
    
    enum Instruction: String, Codable {
        case toTopics
    }
    
    init(withInstruction instruction: Instruction, timeline: Timeline) {
        self.instruction = instruction
        self.timeline = timeline
    }
}
