//
//  TimelineController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class TimelineController {
    
    static func create(timeline: Timeline, forPlayer player: Player) -> Timeline{
        let timeline = Timeline()
        player.timelineID = timeline.id
        return timeline
    }
}
