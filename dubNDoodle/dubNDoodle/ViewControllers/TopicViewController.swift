//
//  TopicViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class TopicViewController: UIViewController {
    
    var displayName: String?
//    var timeline: Timeline?
    var topics: [String]?
    var buttons: [UIButton] = []
    var selectedTopic: String = ""
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    
    lazy var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainOffWhite()
        lbl.textColor = .black
        lbl.text = String(self.time)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Times New Roman", size: 40)
        lbl.layer.borderColor = UIColor.mainScheme3().cgColor
        lbl.layer.cornerRadius = 30
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var barLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainScheme1()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var chooseTopicBelowLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a topic:"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.frame = CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/4 - 60, width: 300, height: 60)
        label.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        return label
    }()
    
    lazy var firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainScheme1()
        button.setTitle("Topic", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.frame = CGRect(x: self.view.frame.width/4 - 50, y: self.view.frame.height/4, width: self.view.frame.width/2 + 100, height: 100)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitle("Topic", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        //        button.layer.cornerRadius = 15
        button.frame = CGRect(x: self.view.frame.width/4 - 50, y: self.view.frame.height/4 + 100, width: self.view.frame.width/2 + 100, height: 100)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var thirdChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainScheme1()
        button.setTitle("Topic", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        //        button.layer.cornerRadius = 15
        button.frame = CGRect(x: self.view.frame.width/4 - 50, y: self.view.frame.height/4 + 200, width: self.view.frame.width/2 + 100, height: 100)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var fourthChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitle("Topic", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.layer.masksToBounds = true
        button.frame = CGRect(x: self.view.frame.width/4 - 50, y: self.view.frame.height/4 + 300, width: self.view.frame.width/2 + 100, height: 100)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var canvasTopBorderView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = UIColor.mainScheme3()
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MCController.shared.delegate = self
        GameController.shared.delegate = self
        view.backgroundColor = UIColor.mainOffWhite()
        
        buttons = [firstChoiceButton,secondChoiceButton,thirdChoiceButton,fourthChoiceButton]
        
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.leftBarButtonItem = nil
        
        
        setupView()
        setTopics()
        
        guard let topics = topics else {return}
        selectedTopic = topics[0]
        
        startTimer()
    }
    
    
    // MARK: - View Setup
    
    func setupView() {
        
        self.view.addSubview(chooseTopicBelowLabel)
        self.view.addSubview(firstChoiceButton)
        self.view.addSubview(secondChoiceButton)
        self.view.addSubview(thirdChoiceButton)
        self.view.addSubview(fourthChoiceButton)
        self.view.addSubview(timerLabel)
        self.view.addSubview(barLabel)
        self.view.addSubview(canvasTopBorderView)

        view.addSubview(barLabel)
        view.addSubview(timerLabel)
        
        canvasTopBorderView.anchor(top: barLabel.bottomAnchor,
                                   left: view.safeAreaLayoutGuide.leftAnchor,
                                   bottom: nil,
                                   right: view.safeAreaLayoutGuide.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 25)
        
        barLabel.anchor(top: view.topAnchor,
                        left: view.safeAreaLayoutGuide.leftAnchor,
                        bottom: nil,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 0,
                        height: 90)
        
        timerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: nil,
                          bottom: nil,
                          right: view.safeAreaLayoutGuide.rightAnchor,
                          paddingTop: 5,
                          paddingLeft: 8,
                          paddingBottom: 5,
                          paddingRight: 8,
                          width: 60,
                          height: 60)
    }
    
    // MARK: Timer
    
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
        if time == 0 {
            let round = roundEnded()
            GameController.shared.endRound(withRound: round)
            resetTimer()
        }
    }
    
    // MARK: - Methods
    
    @objc func buttonTapped(button: UIButton) {
        guard let topic = button.titleLabel?.text else {return}
        selectedTopic = topic
    }
    
    func setTopics(){
        guard let topics = topics else {return}
        for (index,button) in buttons.enumerated() {
            button.setTitle(topics[index], for: .normal)
        }
    }
    
}

// MARK: - GameController Delegate

extension TopicViewController: GameControllerDelegate {
    func advertiserToCanvasView(withRound: Round) {
        print("Advertiser to canvas view")
        DispatchQueue.main.async {
            let canvasView = CanvasViewController()
            canvasView.round = round
            self.navigationController?.pushViewController(canvasView, animated: true)
        }
    }
    
    func advertiserToGuessView(withRound: Round) {
    }
    
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
    }
    
    
    func roundEnded() -> Round {
        let newRound = Round(owner: Player(displayName: "Starter Topic", id: MCPeerID(displayName: "Starter") , isAdvertiser: false), image: nil, guess: selectedTopic, isImage: false)
        return newRound
    }
    
}

// MARK: - MCController Delegate

extension TopicViewController: MCControllerDelegate{
    func toTopicView(withTopics topics: [String]) {
    }
    
    func toCanvasView(round: Round) {
        DispatchQueue.main.async {
            let canvasView = CanvasViewController()
            canvasView.round = round
            self.navigationController?.pushViewController(canvasView, animated: true)
        }
    }
    
    func toGuessView(round: Round) {
        
    }
    
    func toResultsView(timelines: [Timeline]) {
    }
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
}
