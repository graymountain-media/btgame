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
    var seconds = 30
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.shared.delegate = self
        MCController.shared.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
        canvasView.clipsToBounds = true
        canvasView.isMultipleTouchEnabled = false
        gradiantLayer()
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
        self.view.addSubview(timerLabel)
//        self.view.addBackground()
        canvasView.tag = 1
        
        guard let timeline = timeline, let topic = timeline.rounds.last?.guess else {return}
        topicLabel.text = topic
        startTimer()
    }
    
    lazy var viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainScheme1()
        return view
    }()
    func gradiantLayer() {
    let lyr = CAGradientLayer()
    lyr.frame = self.view.bounds
    lyr.colors = [UIColor.mainScheme1().cgColor, UIColor.mainComplement1().cgColor]
        self.view.layer.addSublayer(lyr)
    }
    
    lazy var topicLabel: UILabel = {
        let lbl = UILabel()
        let passedTimeline = timeline
        lbl.frame = CGRect(x: self.view.frame.width/4, y: self.view.frame.height/8, width: self.view.frame.width/2, height: self.view.frame.height/16)
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 15.0
        lbl.textAlignment = .center
        lbl.textColor = .red
        
        return lbl
    }()
    
    lazy var canvasView: CanvasView = {
        let cv = CanvasView()
        cv.frame = CGRect(x: 5, y: self.view.frame.height/6, width: self.view.frame.width - 10, height: self.view.frame.height/1.5)
        cv.backgroundColor = .white
        cv.draw()
        return cv
    }()
    
    lazy var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: self.view.frame.width/6, y: self.view.frame.height/8 * 7, width: self.view.frame.width/4, height: self.view.frame.height/12)
//        lbl.backgroundColor = .gray
        lbl.textColor = .white
        lbl.text = "\(seconds)"
        lbl.font = UIFont(name: "Times New Roman", size: 30)
        return lbl
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
            let timeline = roundEnded()
            GameController.shared.endRound(withTimeline: timeline)
            resetTimer()
        }
    }
    
}

//extension UIView {
//    func addBackground() {
//
//        let width = self.frame.width/1
//        let height = self.frame.height/1
//        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        imageViewBackground.image = UIImage(named: "Background")
//        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
//        self.addSubview(imageViewBackground)
//        self.sendSubview(toBack: imageViewBackground)
//    }
//}

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
