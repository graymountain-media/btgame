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
    
    private init() {
        currentGame = Game(players: [], timeLines: [])
    }
    
    //create game
    func startNewGame() {
        let players: [Player] = []
        let timelines = createTimelines(forPlayers: players)
        currentGame = Game(players: players, timeLines: timelines)
        getTopics()
    }
        //Set game parameters
    
    //add players
    
    //get topics
    
    //assign topics
    
    // MARK: - Private Functions
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
