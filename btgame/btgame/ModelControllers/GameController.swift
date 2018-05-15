//
//  GameController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class GameController {

    static let shared = GameController()
    var currentGame: Game
    var timelines: [Timeline] = []
    var time = 0
    var timer: Timer = Timer()
    
    private init() {
        currentGame = Game(players: [], timeLines: [])
    }
    
    // MARK: - Public Functions
    
    func startNewGame() {
        let players: [Player] = []
        let timelines = createTimelines(forPlayers: players)
        currentGame = Game(players: players, timeLines: timelines)
        getTopics()
    }
    
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
        currentGame.topics = createTopics(count: currentGame.players.count) //replace with network call
    }
    
    func assignTopics() ->[[String]] {
        print("Assign Topics")
        var sortedTopics: [[String]] = []
        var playerTopics: [String] = []
        var topicCount = 0
        print("NEW PLAYER")
        for topic in currentGame.topics {
            playerTopics.append(topic)
            print(topic)
            topicCount += 1
            
            if topicCount > 4 {
                topicCount = 0
                sortedTopics.append(playerTopics)
                playerTopics = []
                print("NEW PLAYER")
            }
        }
        
        return sortedTopics
    }
    
    func createTopics(count: Int) -> [String]{
        var topics: [String] = []
        for i in 1...(count * 4){
            let str = "Choice \(i)"
            print(str)
            topics.append(str)
        }
        return topics
    }
}
