//
//  Constants.swift
//  btgame
//
//  Created by Ray Jex on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

//add any use of strings here and reference the struct in your code elsewhere.
struct Constants {
    static let example = "example"
    
    static let welcome = "Welcome"
    static let to = "to"
    static let gameName = "Dub \nn’ \nDoodle"
    static let host = "Host"
    static let join = "Join"
    static let game = "Game"
    static let begin = "Begin"
    static let enterYourNameBelow = "Enter your name below"
    static let enterUsernamePlaceholderText = "Enter username here..."
    static let pickOneBelowToDraw = "Pick one below to draw"
    static let serviceType = "dubndoodle"
    
    //Custom Cell Identifiers
    static let playerCellIdentifier = "PlayerCell"
    
    static let GuessCell = "GuessCell"
    static let ImageCell = "ImageCell"
    
    //Required num players
    static let requiredNumberOfPlayers = 3
    static var drawingTimeLimit = 25
    static var guessTimeLimit = 10
    
}
