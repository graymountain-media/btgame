//
//  DataManager.swift
//  btgame
//
//  Created by Jake Gray on 5/16/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class DataManager {
    static let shared = DataManager()

    func encodePlayer(player: Player) -> Data? {
        do {
            let encodedPlayer = try JSONEncoder().encode(player)
            return encodedPlayer
        } catch {
            print("Error encoding player: \(error.localizedDescription)")
        }
        return nil
    }

    func decodePlayer(from data: Data) -> Player? {
        do {
            let player = try JSONDecoder().decode(Player.self, from: data)
            return player
        } catch {
            print("Error decoding player: \(error.localizedDescription)")
            return nil
        }
    }
    // This is used for the done button counter (browser sends a '1' to advertiser when they tap the done button)
    func encodeCounter(dict: [String:Int]) -> Data? {
        do {
            let encodedDict = try JSONEncoder().encode(dict)
            return encodedDict
        } catch {
            print("Error encoding player: \(error.localizedDescription)")
        }
        return nil
    }
    
    func decodeCounter(from data: Data) -> [String:Int]? {
        do {
            let dict = try JSONDecoder().decode([String:Int].self, from: data)
            return dict
        } catch {
            print("Error decoding player: \(error.localizedDescription)")
            return nil
        }
    }
    
    func encodeTimeline(timeline: Timeline) -> Data? {
        do {
            let encodedTimeline = try JSONEncoder().encode(timeline)
            return encodedTimeline
        } catch {
            print("Error encoding timeline: \(error.localizedDescription)")
        }
        return nil
    }
    
    func decodeTimeline(from data: Data) -> Timeline? {
        do {
            let timeline = try JSONDecoder().decode(Timeline.self, from: data)
            return timeline
        } catch {
            print("Error decoding player: \(error.localizedDescription)")
            return nil
        }
    }
    
    func decodeData(data: Data) -> [String:Data]? {
        do {
            let decodedData = try JSONDecoder().decode([String:Data].self, from: data)
            return decodedData
        } catch {
            print("Error encoding player: \(error.localizedDescription)")
        }
        return nil
    }
}
