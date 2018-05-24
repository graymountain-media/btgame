//
//  CanvasViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var path = UIBezierPath()
    var startPoint = CGPoint()
    var touchPoint = CGPoint()
    var timeline: Timeline?
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    
    
    lazy var topicLabel: UILabel = {
        let lbl = UILabel()
        let passedTimeline = timeline
        lbl.backgroundColor = UIColor.mainScheme1()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Times New Roman", size: 37)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var canvasView: CanvasView = {
        let cv = CanvasView()
        cv.backgroundColor = .white
        cv.draw()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
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
    
    lazy var canvasTopBorderView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = UIColor.mainScheme3()
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
    }()
    
    lazy var canvasBottomBorderView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = UIColor.mainScheme3()
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
    }()
    
    //    lazy var redButton: UIButton = {
    //        let btn = UIButton()
    //        return btn
    //    }()
    //
    //    lazy var blueButton: UIButton = {
    //        let btn = UIButton()
    //        return btn
    //    }()
    //
    //    lazy var greenButton: UIButton = {
    //        let btn = UIButton()
    //        return btn
    //    }()
    //
    //    lazy var yellowButton: UIButton = {
    //        let btn = UIButton()
    //        return btn
    //    }()
    //
    //    lazy var orangeButton: UIButton = {
    //        let btn = UIButton()
    //        return btn
    //    }()
    
    //    @objc func goToNextView(_ sender: Any) {
    //        let nextView = GuessViewController()
    //        nextView.previousSketch.image = canvasView.makeImage(withView: canvasView)
    //        self.navigationController?.show(nextView, sender: sender)
    //    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.shared.delegate = self
        MCController.shared.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.mainScheme1()
        canvasView.clipsToBounds = true
        canvasView.isMultipleTouchEnabled = false
        canvasView.tag = 1
        
        guard let timeline = timeline, let topic = timeline.rounds.last?.guess else {return}
        topicLabel.text = "   Doodle: \(topic)"
        timerLabel.text = String(time)
        startTimer()
        setupView()
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
        }
        if time == 0 {
            let timeline = roundEnded()
            GameController.shared.endRound(withTimeline: timeline)
            resetTimer()
        }
    }
    
    // MARK: - View Setup
    
    func setupView(){
        
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
        self.view.addSubview(timerLabel)
        self.view.addSubview(canvasTopBorderView)
        self.view.addSubview(canvasBottomBorderView)
        
        topicLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.safeAreaLayoutGuide.leftAnchor,
                        bottom: nil,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 0,
                        height: 70)
        
        canvasTopBorderView.anchor(top: topicLabel.bottomAnchor,
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
        
        timerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: nil,
                         bottom: nil,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 5,
                         paddingLeft: 8,
                         paddingBottom: 0,
                         paddingRight: 8,
                         width: 60,
                         height: 60)

        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.66).isActive = true
        canvasView.topAnchor.constraint(equalTo: canvasTopBorderView.bottomAnchor, constant: 0).isActive = true
        canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

// MARK: - MCController Delegate

extension CanvasViewController: MCControllerDelegate {
    func toCanvasView(timeline: Timeline) {}
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
    func toTopicView(timeline: Timeline) {}
    func toGuessView(timeline: Timeline) {
        DispatchQueue.main.async {
            let nextView = GuessViewController()
            nextView.timeline = timeline
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    func toResultsView(timelines: [Timeline]) {
        DispatchQueue.main.async {
            let resultsView = ResultsViewController()
            resultsView.timelines = timelines
            self.navigationController?.pushViewController(resultsView, animated: true)
        }
    }
}

// MARK: - GameController Delegate

extension CanvasViewController: GameControllerDelegate {
    func advertiserToCanvasView(withTimeLine: Timeline) {
        
    }
    
    func advertiserToGuessView(withTimeLine: Timeline) {
        DispatchQueue.main.async {
            let guessView = GuessViewController()
            guessView.timeline = withTimeLine
            self.navigationController?.pushViewController(guessView, animated: true)
        }
        
    }
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
        DispatchQueue.main.async {
            let resultsView = ResultsViewController()
            resultsView.timelines = timelines
            self.navigationController?.pushViewController(resultsView, animated: true)
        }
    }
    
    func roundEnded() -> Timeline {
        let newRound = Round(owner: MCController.shared.playerArray[0], image: canvasView.makeImage(withView: canvasView), guess: nil, isImage: true)
        guard let timeline = timeline else { return Timeline(owner: MCController.shared.playerArray[0]) }
        timeline.rounds.append(newRound)
        return timeline
    }
}
