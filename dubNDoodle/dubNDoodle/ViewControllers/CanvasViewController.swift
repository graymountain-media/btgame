//
//  CanvasViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class CanvasViewController: UIViewController {
    
//    var path = UIBezierPath()
//    var startPoint = CGPoint()
//    var touchPoint = CGPoint()
    var round: Round?
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    let topicLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.preferredFont(forTextStyle: .title1)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let canvasView: CanvasView = {
        let cv = CanvasView()
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.clipsToBounds = true
        cv.isMultipleTouchEnabled = false
        cv.tag = 1
        return cv
    }()
    
    lazy var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainOffWhite()
        lbl.textColor = .black
        lbl.text = String(self.time)
        lbl.textAlignment = .center
        lbl.font = UIFont.preferredFont(forTextStyle: .title1)
        lbl.layer.borderColor = UIColor.mainScheme3().cgColor
        lbl.layer.cornerRadius = 30
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainScheme1()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let canvasTopBorderView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = UIColor.mainScheme3()
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
    }()
    
    let canvasBottomBorderView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = UIColor.mainScheme3()
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.shared.roundNumberLabelValue += 1
        GameController.shared.delegate = self
        MCController.shared.exitDelegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.mainScheme1()
        
        guard let round = round, let topic = round.guess else {return}
        topicLabel.text = "Doodle: \(topic)"
        timerLabel.text = String(time)
        
        setupView()
        setupBarView()
        startTimer()
    }
    
    // MARK: - Timer
    
    func resetTimer() {
        time = GameController.shared.currentGame.timeLimit
        timer.invalidate()
    }
    
    func startTimer() {
        print("timer started")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
    }
    
    @objc private func timerTicked() {
        time -= 1
        timerLabel.text = String(time)
        print(time)
        if time <= 5 {
            timerLabel.textColor = .red
            UIView.animate(withDuration: 0.3, animations: {
                self.timerLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.3) {
                                self.timerLabel.transform = CGAffineTransform.identity
                                
                            }
                            
            })
        }
        if time == 0 {
            let betweenRoundViewController = BetweenRoundViewController()
            if MCController.shared.currentGamePeers.count < 5 &&  GameController.shared.roundNumberLabelValue > (MCController.shared.currentGamePeers.count * 2) || (MCController.shared.currentGamePeers.count > 5 &&  GameController.shared.roundNumberLabelValue > MCController.shared.currentGamePeers.count)  {
                betweenRoundViewController.setToEndGame()
            }
            self.navigationController?.pushViewController(betweenRoundViewController, animated: true)
            let round = roundEnded()
            GameController.shared.endRound(withRound: round)
            resetTimer()
        }
    }
    
    // MARK: - View Setup
    
    func setupView(){
        
        view.addSubview(barView)
        view.addSubview(canvasView)
        
        view.addSubview(canvasTopBorderView)
        view.addSubview(canvasBottomBorderView)
        
        barView.anchor(top: view.topAnchor,
                          left: view.safeAreaLayoutGuide.leftAnchor,
                          bottom: nil,
                          right: view.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 100)
        
        
        canvasTopBorderView.anchor(top: barView.bottomAnchor,
                                   left: view.safeAreaLayoutGuide.leftAnchor,
                                   bottom: nil,
                                   right: view.safeAreaLayoutGuide.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 30)
        
        canvasBottomBorderView.anchor(top: canvasView.bottomAnchor,
                                      left: view.safeAreaLayoutGuide.leftAnchor,
                                      bottom: nil,
                                      right: view.safeAreaLayoutGuide.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0,
                                      width: 0,
                                      height: 30)
        
        
     
        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.66).isActive = true
        canvasView.topAnchor.constraint(equalTo: canvasTopBorderView.bottomAnchor, constant: 0).isActive = true
        canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        canvasView.draw(CGRect(x: 0, y: 0, width: canvasView.frame.width, height: canvasView.frame.height))
        
        
    }
    
    func setupBarView() {
        barView.addSubview(topicLabel)
        barView.addSubview(timerLabel)
        
        topicLabel.anchor(top: nil,
                          left: barView.leftAnchor,
                          bottom: barView.bottomAnchor,
                          right: timerLabel.leftAnchor,
                          paddingTop: 0,
                          paddingLeft: 8,
                          paddingBottom: 0,
                          paddingRight: 8,
                          width: 0,
                          height: 60)
        
        timerLabel.anchor(top: nil,
                          left: nil,
                          bottom: barView.bottomAnchor,
                          right: barView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: -5,
                          paddingRight: 8,
                          width: 60,
                          height: 60)
    }
}

// MARK: - GameController Delegate

extension CanvasViewController: GameControllerDelegate {
    
    func advertiserToCanvasView(withRound: Round) {
    }
    func advertiserToGuessView(withRound: Round) {
    }
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
    }
    
    func roundEnded() -> Round {
        let newRound = Round(owner: MCController.shared.playerArray[0], image: canvasView.makeImage(withView: canvasView), guess: nil, isImage: true)
        
        return newRound
    }
}
extension CanvasViewController: MCExitGameDelegate {
    func exitGame(peerID: MCPeerID) {
        if self == navigationController?.topViewController {
            let alertCon = UIAlertController(title: "Sorry", message: "\(peerID.displayName) blew it! You must restart game!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Exit", style: .default){ (action) in
                
                MCController.shared.advertiserAssistant?.stop()
                MCController.shared.currentGamePeers = []
                MCController.shared.playerArray = []
                MCController.shared.peerIDDict = [:]
                MCController.shared.session.disconnect()
                GameController.shared.clearData()
                MCController.shared.advertiser?.stopAdvertisingPeer()
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            alertCon.addAction(okAction)
            self.present(alertCon, animated: true, completion: nil)
        }
    }
    
    
}
