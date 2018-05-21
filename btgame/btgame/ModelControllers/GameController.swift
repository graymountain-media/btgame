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
    func advertiserToResultsView(withTimelines timelines: [Timeline])

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
        currentGame.numberOfRounds = playerOrder.count * 2
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
        
        refreshTimelines()
        roundNumber += 1
        if roundNumber > currentGame.numberOfRounds {
            endGame()
            return
        }
        isDrawingRound = !isDrawingRound
        if isDrawingRound {
            print("COMFIRMED DRAWING ROUND")
            nextRoundInstruction = .toCanvas
        } else {
            print("COMFIRMED GUESS ROUND")
            nextRoundInstruction = .toGuess
        }
        print("SHIFT TIMELINES")
        shiftTimelines()
        
        for (index,player) in playerOrder.enumerated() {
            if player.isAdvertiser != true {
                guard let peerID = MCController.shared.peerIDDict[player] else {return}
                
                MCController.shared.sendEvent(withInstruction: nextRoundInstruction, timeline: orderedTimelines[index], toPeers: peerID)
                print("SENT BROWSER NEXT TIMELINE")
            } else {
                print("SEND ADVERTISER TO NEXT VIEW")
                sendAdvertiserToNextView(withTimeline: orderedTimelines[index])
            }
        }
    }
    
    func refreshTimelines(){
        for (index, oldTimeline) in orderedTimelines.enumerated() {
            for newTimeline in returnedTimelines {
                if newTimeline.id == oldTimeline.id {
                    orderedTimelines.remove(at: index)
                    orderedTimelines.insert(newTimeline, at: index)
                }
            }
        }
        returnedTimelines = []
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
        print("PLAYER ORDER: \(playerOrder.compactMap({$0.displayName}))")
        print("TIMELINE ORDER: \(orderedTimelines.compactMap({$0.id}))")
        
    }
    
    func endRound(withTimeline timeline: Timeline) {
        
        if (!MCController.shared.isAdvertiser) {
            MCController.shared.sendEvent(withInstruction: .endRoundReturn, timeline: timeline, toPeers: MCController.shared.peerIDDict[MCController.shared.playerArray[1]]!)
        } else {
            print("Advertiser append timeline")
            returnedTimelines.append(timeline)
            if (returnedTimelines.count) >= MCController.shared.currentGamePeers.count {
                startNewRound()
            }
        }
    }
    
    func endGame(){
        for player in playerOrder {
            if player.isAdvertiser == false {
                
                var sortedTimelines: [Timeline] = []
                for timeline in orderedTimelines {
                    if timeline.owner == player {
                        sortedTimelines.insert(timeline, at: 0)
                    } else {
                        sortedTimelines.append(timeline)
                    }
                }
                
                guard let peerID = MCController.shared.peerIDDict[player] else {return}
                MCController.shared.sendFinalEvent(withInstruction: .endGame, timelines: sortedTimelines, toPeers: peerID)

            } else {
                var sortedTimelines: [Timeline] = []
                for timeline in orderedTimelines {
                    if timeline.owner == player {
                        sortedTimelines.insert(timeline, at: 0)
                    } else {
                        sortedTimelines.append(timeline)
                    }
                }
                
                delegate?.advertiserToResultsView(withTimelines: sortedTimelines)
            }
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
