//
//  Round.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class Round {
    let owner: Player
    var image: UIImage?
    var guess: String?
    var isImage: Bool
    
    init(owner: Player, image: UIImage? = nil, guess: String? = nil isImage: Bool = false) {
        self.owner = owner
        self.image = image
        self.guess = guess
        self.isImage = isImage
    }
}
