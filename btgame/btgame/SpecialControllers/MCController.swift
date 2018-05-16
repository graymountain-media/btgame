// PIERCE OWNS THIS FILE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// READ ABOVE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//  MCController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import CoreBluetooth

//protocol MCControllerDelegate {
//    func playerJoinedSession()
//}

class MCController: NSObject, MCSessionDelegate {
    
    // MARK: - Shared Instance
    static let shared = MCController()
    
    // MARK: - Properties
    
    var isAdvertiser = false
    var displayName: String?
//    var delegate: MCControllerDelegate?
    var session: MCSession!
    var peerID: MCPeerID!
    var browser: MCBrowserViewController!
    var advertiser: MCNearbyServiceAdvertiser!
    var advertiserAssistant: MCAdvertiserAssistant!
    var currentGamePeers = [MCPeerID]()
    
    // MARK: - Manager Initializer
    override init() {
        super.init()
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        
        // May need to change
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        currentGamePeers.append(peerID)
        
        //login on welcomeview option
        browser = MCBrowserViewController(serviceType: "BoardBuddy", session: session)
        advertiserAssistant = MCAdvertiserAssistant(serviceType: "BoardBuddy", discoveryInfo: nil, session: session)
    }
    
    
    // MARK: - MCSession delegate functions
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state{
        case MCSessionState.connected:
            print("Connected to session")
            currentGamePeers.append(peerID)
//            delegate?.playerJoinedSession()
            
        case MCSessionState.connecting:
            print("Connecting to session")
            
        default:
            print("Did not connect to session")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // turn data to person object
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Nothing to do here
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Nothing to do here
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Nothing to do here
    }
}
