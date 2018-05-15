//
//  RoundController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class RoundController {
    
    static func create(round: Round, withImage image: UIImage?, orGuess guess: String?, owner: Player , inTimeline timeline: Timeline) {
        var isImage = false
        if image != nil {
            isImage =  true
        }
        
        let round = Round(owner: owner, image: image, guess: guess, isImage: isImage)
        timeline.rounds.append(round)
    }
    
    static func delete(round: Round, fromTimeline timeline: Timeline){
        let index = timeline.rounds.index(of: round)
        
        if let index = index {
            timeline.rounds.remove(at: index)
        }
    }
}
