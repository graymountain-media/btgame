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
    func encodeCounter(counter: Counter) -> Data? {
        do {
            let encodedCounter = try JSONEncoder().encode(counter)
            return encodedCounter
        } catch {
            print("Error encoding counter: \(error.localizedDescription)")
        }
        return nil
    }
    
    func decodeCounter(from data: Data) -> Counter? {
        do {
            let decodedCounter = try JSONDecoder().decode(Counter.self, from: data)
            return decodedCounter
        } catch {
            print("Error decoding counter: \(error.localizedDescription)")
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
            print("Error decoding timeline: \(error.localizedDescription)")
            return nil
        }
    }
    
    func encodeEvent(event: Event) -> Data? {
        do {
            let encodedEvent = try JSONEncoder().encode(event)
            return encodedEvent
        } catch {
            print("Error encoding event: \(error.localizedDescription)")
        }
        return nil
    }
    
    func decodeEvent(from data: Data) -> Event? {
        do {
            let event = try JSONDecoder().decode(Event.self, from: data)
            return event
        } catch {
            print("Error decoding event: \(error.localizedDescription)")
            return nil
        }
    }
    
    func encodeEventObject(eventObject: [String:Data]) -> Data? {
        do {
            let encodedEventObject = try JSONEncoder().encode(eventObject)
            return encodedEventObject
        } catch {
            print("Error encoding event object: \(error.localizedDescription)")
        }
        return nil
    }
    
    func decodeEventObject(from data: Data) -> [String:Data]? {
        do {
            let eventObject = try JSONDecoder().decode([String:Data].self, from: data)
            return eventObject
        } catch {
            print("Error decoding event object: \(error.localizedDescription)")
            return nil
        }
    }
}
