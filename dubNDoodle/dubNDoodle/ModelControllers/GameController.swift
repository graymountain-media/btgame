//
//  GameController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

protocol GameControllerDelegate: class {
    func roundEnded() -> Round
    func advertiserToCanvasView(withRound: Round)
    func advertiserToGuessView(withRound: Round)
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
    var returnedRounds: [Round] = []
    var roundNumber = 0
    var nextRoundInstruction = Event.Instruction.toCanvas
    var roundNumberLabelValue = 0
    
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
        if playerOrder.count < 5 {
            currentGame.numberOfRounds = playerOrder.count * 2
        } else {
            currentGame.numberOfRounds = playerOrder.count
        }
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
                MCController.shared.sendTopicsEvent(withTopics: timeline.possibleTopics, fromPlayer: 0, toPeer: peerID)
            }
        }
    }
    
    func startNewRound () {
        
        returnedRounds = []
        
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
                guard let peerID = MCController.shared.peerIDDict[player], let round = orderedTimelines[index].rounds.last else {return}
                
                MCController.shared.sendEvent(withInstruction: nextRoundInstruction, round: round, fromPlayer: 0, toPeer: peerID)
                print("SENT BROWSER NEXT TIMELINE")
            } else {
                print("SEND ADVERTISER TO NEXT VIEW")
                guard let round = orderedTimelines[index].rounds.last else {return}
                sendAdvertiserToNextView(withRound: round)
            }
        }
    }
    
    
    func sendAdvertiserToNextView(withRound round: Round){
        if isDrawingRound {
            delegate?.advertiserToCanvasView(withRound: round)
        } else {
            delegate?.advertiserToGuessView(withRound: round)
        }
    }
    
    fileprivate func shiftTimelines(){
        guard let player = playerOrder.popLast() else {return}
        playerOrder.insert(player, at: 0)
        print("PLAYER ORDER: \(playerOrder.compactMap({$0.displayName}))")
        print("TIMELINE ORDER: \(orderedTimelines.compactMap({$0.id}))")
        
    }
    
    func endRound(withRound round: Round) {
        
        if (!MCController.shared.isAdvertiser) {
            MCController.shared.sendEvent(withInstruction: .endRoundReturn, round: round, fromPlayer: MCController.shared.playerArray[0].uid,  toPeer: MCController.shared.peerIDDict[MCController.shared.playerArray[1]]!)
        } else {
            print("Advertiser append timeline")
            
            for (index,player) in playerOrder.enumerated() {
                if player.isAdvertiser {
                    orderedTimelines[index].rounds.append(round)
                }
            }
            returnedRounds.append(round)
            if (returnedRounds.count) >= MCController.shared.currentGamePeers.count {
                startNewRound()
            }
        }
    }
    
    func endGame(){
        for player in playerOrder {
            if player.isAdvertiser == false {
                
                DispatchQueue.global(qos: .userInitiated).async {
                    var sortedTimelines: [Timeline] = []
                    for timeline in self.orderedTimelines {
                        if timeline.owner == player {
                            sortedTimelines.insert(timeline, at: 0)
                        } else {
                            sortedTimelines.append(timeline)
                        }
                    }
                    print("Browser timelines: \(sortedTimelines)")
                    
                    guard let peerID = MCController.shared.peerIDDict[player] else {return}
                    print("Peer ID \(peerID)")
                    MCController.shared.sendFinalEvent(withInstruction: .endGame, timelines: sortedTimelines, toPeers: peerID)
                }
                
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
    func clearData() {
        isDrawingRound = false
        playerOrder = []
        orderedTimelines = []
        returnedRounds = []
        roundNumber = 0
        nextRoundInstruction = Event.Instruction.toCanvas
    }
}
