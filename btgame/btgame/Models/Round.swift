//
//  Round.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class Round: Codable {
    let owner: Player
    var imageData: Data?
    var guess: String?
    var isImage: Bool
    
    init(owner: Player, image: UIImage? = nil, guess: String? = nil, isImage: Bool = false) {
        self.owner = owner
        self.imageData = image == nil ? nil : UIImagePNGRepresentation(image!)
        self.guess = guess
        self.isImage = isImage
    }
}

extension Round: Equatable {
    static func == (lhs: Round, rhs: Round) -> Bool {
        return (lhs.owner == rhs.owner && lhs.imageData == rhs.imageData && lhs.guess == rhs.guess && lhs.isImage == rhs.isImage)
    }
}
