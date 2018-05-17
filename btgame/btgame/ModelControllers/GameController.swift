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
//    var timelines: [Timeline] = []
    var time = 0
    var timer: Timer = Timer()
    var isDrawingRound: Bool
    var turnOrder: [UUID:Player] = [:]
    
    private init() {
        currentGame = Game(players: [], timelines: [])
        isDrawingRound = false
    }
    
    // MARK: - Public Functions
    
    func startNewGame(players: [Player]) {
        let timelines = createTimelines(forPlayers: players)
        currentGame = Game(players: players, timelines: timelines)
        getTopics()
        time = currentGame.timeLimit
        createTurnOrder()
        distributeTopics()
    }
    
    func createTurnOrder(){
        for i in 0...currentGame.players.count - 1 {
            turnOrder[currentGame.timelines[i].id] = currentGame.timelines[i].owner
        }
    }
    func distributeTopics(){
        for timeline in currentGame.timelines {
            if timeline.owner != currentGame.players[0] {
                guard let peerID = MCController.shared.peerIDDict[timeline.owner] else {
                    print("Failed sending first round")
                    return}
                print("send timeline")
                MCController.shared.sendEvent(withInstruction: .toTopics, timeline: timeline, toPeers: peerID)
            }
        }
    }
    
    func endRound(forPlayer player: Player, withImage image: UIImage?, guess: String?, timeline: Timeline) {
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
            turnOrder[newTimeline.id] = player
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
        
        for timeline in currentGame.timelines {
            for _ in 1...4{
                let index = getNumber()
                timeline.possibleTopics.append(topics_all[Int(index)])
            }
        }
    }
}
