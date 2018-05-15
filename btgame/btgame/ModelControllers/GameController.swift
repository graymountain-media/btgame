//
//  GameController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class GameController {

    static let shared = GameController()
    var currentGame: Game
    var timelines: [Timeline] = []
    var time = 0
    var timer: Timer = Timer()
    var isDrawingRound: Bool
    
    private init() {
        currentGame = Game(players: [], timeLines: [])
        isDrawingRound = false
    }
    
    // MARK: - Public Functions
    
    func startNewGame() {
        let players: [Player] = []
        let timelines = createTimelines(forPlayers: players)
        currentGame = Game(players: players, timeLines: timelines)
        getTopics()
    }
    
    func endRound(forPlayer player: Player, withImage image: UIImage?, guess: String?, timeLine: Timeline) {
        RoundController.createRound(withImage: image, orGuess: guess, owner: player, inTimeline: timeline )
    }
    
    // MARK: Timer
    
    func resetTimer() {
        time = currentGame.timeLimit
        timer.invalidate()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
    } 
    
    // MARK: - Private Functions
    
    @objc private func timerTicked() {
        time -= 1
        if time == 0 {
            //FIXME: GO to next phase
            resetTimer()
        }
    }
    
    private func createTimelines(forPlayers players: [Player]) -> [Timeline] {
        var timelines: [Timeline] = []
        for player in players {
            let newTimeline = TimelineController.createTimeline(forPlayer: player)
            timelines.append(newTimeline)
        }
        
        return timelines
    }
    
    private func getTopics(){
        var usedNumbers: [UInt32] = []
        func getNumber() -> UInt32 {
            let randomNumber = arc4random_uniform(UInt32(topics_all.count))
            if usedNumbers.contains(randomNumber) {
                return getNumber()
            } else {
                usedNumbers.append(randomNumber)
                return randomNumber
            }
        }
        
        for player in currentGame.players {
            for _ in 1...4{
                let index = getNumber()
                player.possibleTopics.append(topics_all[Int(index)])
            }
        }
    }
}
