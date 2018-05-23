 //
 //  GuessViewController.swift
 //  btgame
 //
 //  Created by Jake Gray on 5/15/18.
 //  Copyright © 2018 Jake Gray. All rights reserved.
 //
 
 import UIKit
 
 class GuessViewController: UIViewController {
    
    var timeline: Timeline?
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameController.shared.delegate = self
        MCController.shared.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.mainScheme3()
        
        self.view.addSubview(guessTextField)
        self.view.addSubview(previousSketch)
        self.view.addSubview(timeLabel)
        self.view.addSubview(barLabel)
        
        //        setupView()
        
        let passedTimeline = timeline
        guard let data = passedTimeline?.rounds.last?.imageData else { return }
        let image = UIImage(data: data)
        previousSketch.image = image
        startTimer()
    }
    
    //    lazy var viewContainer: UIView = {
    //        let vc = UIView()
    //        vc.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/1, height: self.view.frame.height/1)
    //        vc.backgroundColor = .red
    //        return vc
    //    }()
    
    lazy var previousSketch: UIImageView = {
        let ps = UIImageView()
        ps.frame = CGRect(x: 0, y: self.view.frame.height/6, width: self.view.frame.width/1, height: self.view.frame.height/1.5)
        ps.backgroundColor = .white
        ps.contentMode = .scaleAspectFit
        return ps
    }()
    
    lazy var guessTextField: UITextField = {
        let gtf = UITextField()
//        gtf.frame = CGRect(x: 0, y: self.view.frame.height - 140 , width: self.view.frame.width, height: 60)
        gtf.anchor(top: previousSketch.bottomAnchor,
                   left: self.view.leftAnchor,
                   bottom: nil,
                   right: self.view.rightAnchor,
                   paddingTop: 0,
                   paddingLeft: 0,
                   paddingBottom: 0,
                   paddingRight: 0,
                   width: self.view.frame.width,
                   height: 60)
        gtf.backgroundColor = .white
        gtf.font = UIFont(name: "Times New Roman", size: 30)
        gtf.textColor = .black
        gtf.placeholder = "Enter Guess"
        gtf.layer.borderColor = UIColor.black.cgColor
        gtf.layer.borderWidth = 2.0
        return gtf
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: self.view.frame.width - 80, y: 0, width: 80, height: 80)
        label.backgroundColor = UIColor.mainScheme1()
        label.font = UIFont(name: "Times New Roman", size: 40)
        label.textAlignment = .center
        label.textColor = UIColor(red: 251.0/255.0, green: 254.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        return label
    }()
    
    lazy var barLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainScheme1()
        lbl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 80)
        return lbl
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
    
 }
 
 extension GuessViewController: MCControllerDelegate {
    func toGuessView(timeline: Timeline) {}
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
    func toTopicView(timeline: Timeline) {}
    func toCanvasView(timeline: Timeline) {
        DispatchQueue.main.async {
            let nextView = CanvasViewController()
            nextView.timeline = timeline
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    func toResultsView(timelines: [Timeline]) {
        print("Guess view did end game")
        DispatchQueue.main.async {
            let resultsView = ResultsViewController()
            resultsView.timelines = timelines
            print("DELEGATE TIMELINES: \(timelines)")
            self.navigationController?.pushViewController(resultsView, animated: true)
            
        }
    }
 }
 
 extension GuessViewController: GameControllerDelegate {
    func advertiserToCanvasView(withTimeLine: Timeline) {
        DispatchQueue.main.async {
            let canvasView = CanvasViewController()
            canvasView.timeline = withTimeLine
            self.navigationController?.pushViewController(canvasView, animated: true)
        }
        
    }
    
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
        DispatchQueue.main.async {
            let resultsView = ResultsViewController()
            resultsView.timelines = timelines
            self.navigationController?.pushViewController(resultsView, animated: true)
        }
    }
    
    func advertiserToGuessView(withTimeLine: Timeline) {
    }
    
    func roundEnded() -> Timeline {
        let newRound = Round(owner: MCController.shared.playerArray[0], image: nil, guess: guessTextField.text, isImage: false)
        guard let timeline = timeline else { return Timeline(owner: MCController.shared.playerArray[0]) }
        timeline.rounds.append(newRound)
        return timeline
    }
 }
