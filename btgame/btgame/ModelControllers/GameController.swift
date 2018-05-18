//
//  GameController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

protocol GameControllerDelegate: class {
    func roundEnded() -> Timeline
}
class GameController {
    
    static let shared = GameController()
    var currentGame: Game
//    var timelines: [Timeline] = []
    var time = 0
    var timer: Timer = Timer()
    var isDrawingRound: Bool
    var playerOrder: [Player] = []
    var timelineOrder: [Timeline] = []
    var roundNumber = 1
    
    weak var delegate: GameControllerDelegate?
    
    private init() {
        currentGame = Game(players: [], timelines: [])
        isDrawingRound = false
    }
    
    // MARK: - Public Functions
    
    func startNewGame(players: [Player]) {
        createTurnOrder()
        createTimelines(forPlayers: players)
        print("START NEW GAME TIMELINES: \(timelineOrder)")
        print("START NEW GAME PLAYER ORDER: \(playerOrder)")
        currentGame = Game(players: players, timelines: timelineOrder)
        getTopics()
        time = currentGame.timeLimit
        roundNumber = 1
        distributeTopics()
    }
    
    func createTurnOrder(){
        let isBefore = arc4random_uniform(2)
        for player in MCController.shared.playerArray {            if isBefore == 1 {
                playerOrder.insert(player, at: 0)
            } else {
                playerOrder.append(player)
            }
        }
    }
    
    func distributeTopics(){
        print("Distribute topics")
        print(timelineOrder)
        for timeline in timelineOrder {
            print(timeline.owner)
            if timeline.owner != currentGame.players[0] {
                
                guard let peerID = MCController.shared.peerIDDict[timeline.owner] else {
                    print("Failed sending first round")
                    return}
                print("send timeline")
                MCController.shared.sendEvent(withInstruction: .toTopics, timeline: timeline, toPeers: peerID)
            }
        }
    }
    
    func startNewRound () {
        var nextRoundINstruction = Event.Instruction.toCanvas
        //increment turn number
        roundNumber += 1
            //determine whether to continue
        if roundNumber > currentGame.numberOfRounds {
            //End game
        }
        if (timelineOrder[0].rounds.last?.isImage)! {
            nextRoundINstruction = .toGuess
        } else {
            nextRoundINstruction = .toCanvas
        }
        
        //shift turn order
        shiftRounds()
        //send out newturn event
        for (index,player) in playerOrder.enumerated() {
            guard let peerID = MCController.shared.peerIDDict[player] else {return}
            MCController.shared.sendEvent(withInstruction: nextRoundINstruction, timeline: timelineOrder[index], toPeers: peerID)
        }
    }
    
    fileprivate func shiftRounds(){
        guard let player = playerOrder.popLast() else {return}
        playerOrder.insert(player, at: 0)
    }
    
    func endRound(withTimeline timeline: Timeline) {
        
//        guard let timeline = delegate?.roundEnded() else {
//            print("No timline returned from view")
//            return
//        }
        
        if (!MCController.shared.isAdvertiser) {
            MCController.shared.sendEvent(withInstruction: .endRoundReturn, timeline: timeline, toPeers: MCController.shared.peerIDDict[MCController.shared.playerArray[1]]!)
        } else {
            currentGame.returnedTimelines.append(timeline)
        }
        
        
    }
    
    // MARK: Timer
    
    func resetTimer() {
        time = currentGame.timeLimit
        timer.invalidate()
    }
    
    func startTimer() {
        print("timer started")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
    }
    
    
    // MARK: - Private Functions
    
    @objc private func timerTicked() {
        time -= 1
        print(time)
        if time == 0 {
            print("Wrong timer")
           // endRound()
            resetTimer()
        }
    }
    
    private func createTimelines(forPlayers players: [Player]) {
        for player in playerOrder {
            let newTimeline = TimelineController.createTimeline(forPlayer: player)
            timelineOrder.append(newTimeline)
        }
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
