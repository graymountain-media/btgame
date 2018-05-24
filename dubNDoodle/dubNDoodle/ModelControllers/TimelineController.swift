//
//  TimelineController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class TimelineController {
    
    static func createTimeline(forPlayer player: Player) -> Timeline{
        let timeline = Timeline(owner: player)
        return timeline
    }
}
