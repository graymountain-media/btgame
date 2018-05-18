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
    func advertiserToCanvasView(withTimeLine: Timeline)
    func advertiserToGuessView(withTimeLine: Timeline)

}
class GameController {
    
    static let shared = GameController()
    var currentGame: Game
    var time = 0
    var timer: Timer = Timer()
    var isDrawingRound: Bool
    var playerOrder: [Player] = []
    var orderedTimelines: [Timeline] = []
    var returnedTimelines: [Timeline] = []
    var roundNumber = 0
    var nextRoundInstruction = Event.Instruction.toCanvas
    
    weak var delegate: GameControllerDelegate?
    
    private init() {
        currentGame = Game(players: [], timelines: [])
        isDrawingRound = false
    }
    
    // MARK: - Public Functions
    
    func startNewGame(players: [Player]) {
        createTurnOrder()
        createTimelines(forPlayers: players)
        currentGame = Game(players: players, timelines: orderedTimelines)
        getTopics()
        time = currentGame.timeLimit
        roundNumber = 1
        distributeTopics()
    }
    
    func createTurnOrder(){
        let isBefore = arc4random_uniform(2)
        for player in MCController.shared.playerArray {
            if isBefore == 1 {
                playerOrder.insert(player, at: 0)
            } else {
                playerOrder.append(player)
            }
        }
    }
    
    func distributeTopics(){
        for timeline in orderedTimelines {
            if timeline.owner != currentGame.players[0] {
                guard let peerID = MCController.shared.peerIDDict[timeline.owner] else {
                    print("Failed sending first round")
                    return}
                MCController.shared.sendEvent(withInstruction: .toTopics, timeline: timeline, toPeers: peerID)
            }
        }
    }
    
    func startNewRound () {
        roundNumber += 1
        if roundNumber > currentGame.numberOfRounds {
        }
        isDrawingRound = !isDrawingRound
        if isDrawingRound {
            nextRoundInstruction = .toCanvas
        } else {
            nextRoundInstruction = .toGuess
        }
        shiftTimelines()
        
        for (index,player) in playerOrder.enumerated() {
            if player.isAdvertiser != true {
                guard let peerID = MCController.shared.peerIDDict[player] else {return}
                MCController.shared.sendEvent(withInstruction: nextRoundInstruction, timeline: orderedTimelines[index], toPeers: peerID)
            } else {
                sendAdvertiserToNextView(withTimeline: orderedTimelines[index])
            }
        }
    }
    
    func sendAdvertiserToNextView(withTimeline timeline: Timeline){
        if isDrawingRound {
            delegate?.advertiserToCanvasView(withTimeLine: timeline)
        } else {
            delegate?.advertiserToGuessView(withTimeLine: timeline)
        }
    }
    
    fileprivate func shiftTimelines(){
        guard let player = playerOrder.popLast() else {return}
        playerOrder.insert(player, at: 0)
    }
    
    func endRound(withTimeline timeline: Timeline) {
        
        if (!MCController.shared.isAdvertiser) {
            MCController.shared.sendEvent(withInstruction: .endRoundReturn, timeline: timeline, toPeers: MCController.shared.peerIDDict[MCController.shared.playerArray[1]]!)
        } else {
            returnedTimelines.append(timeline)
        }
    }
    
    private func createTimelines(forPlayers players: [Player]) {
        for player in playerOrder {
            let newTimeline = TimelineController.createTimeline(forPlayer: player)
            orderedTimelines.append(newTimeline)
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
        
        for timeline in orderedTimelines {
            for _ in 1...4{
                let index = getNumber()
                timeline.possibleTopics.append(topics_all[Int(index)])
            }
        }
    }
}
