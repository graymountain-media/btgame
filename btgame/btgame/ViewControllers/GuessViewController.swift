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
        self.view.backgroundColor = .red
        
        self.view.addSubview(guessTextField)
        self.view.addSubview(previousSketch)
        self.view.addSubview(timeLabel)
        setupView()
        
        let passedTimeline = timeline
        guard let data = passedTimeline?.rounds.last?.imageData else { return }
        let image = UIImage(data: data)
        previousSketch.image = image
        startTimer()
    }
    
    lazy var viewContainer: UIView = {
        let vc = UIView()
//        vc.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/1, height: self.view.frame.height/1)
        vc.backgroundColor = .red
        return vc
    }()
    
    let previousSketch: UIImageView = {
        let ps = UIImageView()
//        ps.frame = CGRect(x: 0, y: 100, width: 450, height: 500)
        ps.backgroundColor = .white
        ps.contentMode = .scaleAspectFit
        return ps
    }()
    
    let guessTextField: UITextField = {
        let gtf = UITextField()
//        gtf.frame = CGRect(x: 50, y: 600, width: 350, height: 70)
        gtf.backgroundColor = .white
        gtf.textColor = .black
        gtf.placeholder = "Enter Guess"
        return gtf
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    func setupView(){
        previousSketch.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              bottom: nil,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: 40,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 300)
        
        guessTextField.anchor(top: previousSketch.bottomAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              bottom: nil,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              paddingTop: 8,
                              paddingLeft: 16,
                              paddingBottom: 0,
                              paddingRight: 16,
                              width: 0,
                              height: 44)
        timeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: nil,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 0)
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
        DispatchQueue.main.async {
            let resultsView = ResultsViewController()
            resultsView.timelines = timelines
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
