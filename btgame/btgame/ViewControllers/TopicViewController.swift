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
    var timeline: Timeline?
    var buttons: [UIButton] = []
    var selectedTopic: String = ""
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MCController.shared.delegate = self
        GameController.shared.delegate = self
        buttons = [firstChoiceButton,secondChoiceButton,thirdChoiceButton,fourthChoiceButton]
        
        self.navigationController?.navigationBar.isHidden = true
        
        // Views
        //        view.addSubview(containerView)
        navigationItem.leftBarButtonItem = nil
        self.view.addSubview(chooseTopicBelowLabel)
        self.view.addSubview(firstChoiceButton)
        self.view.addSubview(secondChoiceButton)
        self.view.addSubview(thirdChoiceButton)
        self.view.addSubview(fourthChoiceButton)
        self.view.addSubview(timeLabel)
        self.view.addSubview(barLabel)
        
        // Contstraints
        //        setupContainerView()
        setTopics()
        guard let timeline = timeline else {return}
        selectedTopic = timeline.possibleTopics[0]
        startTimer()
    }
    
    //    let containerView: UIView = {
    //
    //        let view = UIView()
    //        view.backgroundColor = UIColor.white
    //        view.translatesAutoresizingMaskIntoConstraints = false
    ////        view.layer.cornerRadius = 25
    //        view.layer.masksToBounds = true
    //        return view
    //    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = String(self.time)
        label.frame = CGRect(x: self.view.frame.width - 80, y: 0, width: 80, height: 80)
        label.textAlignment = .center
        label.font = UIFont(name: "Times New Roman", size: 40)
        label.textColor = UIColor(red: 251.0/255.0, green: 254.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        label.backgroundColor = UIColor.mainScheme1()
        return label
    }()
    
    lazy var barLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 80)
        lbl.backgroundColor = UIColor.mainScheme1()
        return lbl
    }()
    
    lazy var chooseTopicBelowLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose one below"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.frame = CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/4 - 100, width: 300, height: 60)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainScheme1()
        button.setTitle("Topic", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        //        button.layer.cornerRadius = 15
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
        timeLabel.text = String(time)
        print(time)
        if time == 0 {
            let timeline = roundEnded()
            GameController.shared.endRound(withTimeline: timeline)
            resetTimer()
        }
    }
    
    @objc func buttonTapped(button: UIButton) {
        guard let topic = button.titleLabel?.text else {return}
        selectedTopic = topic
    }
    
    func setTopics(){
        guard let timeline = timeline else {return}
        for (index,button) in buttons.enumerated() {
            button.setTitle(timeline.possibleTopics[index], for: .normal)
        }
    }
    
}
extension TopicViewController: GameControllerDelegate {
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
        
    }
    
    
    func roundEnded() -> Timeline {
        let newRound = Round(owner: Player(displayName: "Starter Topic", id: MCPeerID(displayName: "Starter") , isAdvertiser: false), image: nil, guess: selectedTopic, isImage: false)
        
        guard let timeline = self.timeline else {return Timeline(owner: MCController.shared.playerArray[0])}
        
        timeline.rounds.append(newRound)
        return timeline
    }
    
    func advertiserToCanvasView(withTimeLine: Timeline) {
        print("Advertiser to canvas view")
        DispatchQueue.main.async {
            let canvasView = CanvasViewController()
            canvasView.timeline = withTimeLine
            self.navigationController?.pushViewController(canvasView, animated: true)
        }
    }
    
    func advertiserToGuessView(withTimeLine: Timeline) {
    }
    
}

extension TopicViewController: MCControllerDelegate{
    func toResultsView(timelines: [Timeline]) {
        
    }
    
    
    func toCanvasView(timeline: Timeline) {
        DispatchQueue.main.async {
            let canvasView = CanvasViewController()
            canvasView.timeline = timeline
            self.navigationController?.pushViewController(canvasView, animated: true)
        }
    }
    
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
    func toTopicView(timeline: Timeline) {}
    func toGuessView(timeline: Timeline) {}
}
