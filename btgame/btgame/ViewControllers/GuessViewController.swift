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
    
    lazy var previousSketch: UIImageView = {
        let ps = UIImageView()
        ps.backgroundColor = .white
        ps.contentMode = .scaleAspectFit
        ps.translatesAutoresizingMaskIntoConstraints = false
        return ps
    }()
    
    lazy var guessTextField: UITextField = {
        let gtf = UITextField()
        gtf.backgroundColor = UIColor.mainOffWhite()
        gtf.textColor = .black
        gtf.placeholder = "Enter Guess"
        gtf.layer.borderColor = UIColor.mainScheme1().cgColor
        gtf.layer.borderWidth = 1.0
        gtf.translatesAutoresizingMaskIntoConstraints = false
        gtf.setPadding()
        return gtf
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mainOffWhite()
        label.font = UIFont(name: "Times New Roman", size: 40)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.mainScheme3().cgColor
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        return label
    }()
    
    lazy var barLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainScheme1()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.font = UIFont(name: "Times New Roman", size: 35)
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameController.shared.delegate = self
        MCController.shared.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.mainScheme1()
        
        setupView()
        
        let passedTimeline = timeline
        guard let data = passedTimeline?.rounds.last?.imageData else { return }
        let image = UIImage(data: data)
        previousSketch.image = image
        barLabel.text = "   Dub this Doodle"
        timerLabel.text = String(time)
        startTimer()
    }
    
    
    //MARK: - View Setup
    
    func setupView() {
        view.addSubview(barLabel)
        view.addSubview(timerLabel)
        view.addSubview(previousSketch)
        view.addSubview(guessTextField)
        view.addSubview(canvasTopBorderView)
        view.addSubview(canvasBottomBorderView)
        
        barLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.safeAreaLayoutGuide.leftAnchor,
                        bottom: nil,
                        right: view.safeAreaLayoutGuide.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 0,
                        height: 70)
        
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
        
        canvasTopBorderView.anchor(top: barLabel.bottomAnchor,
                                   left: view.safeAreaLayoutGuide.leftAnchor,
                                   bottom: nil,
                                   right: view.safeAreaLayoutGuide.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 30)
        
        guessTextField.anchor(top: canvasTopBorderView.bottomAnchor,
                         left: self.view.leftAnchor,
                         bottom: nil,
                         right: self.view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: self.view.frame.width,
                         height: 44)
        
        previousSketch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.66).isActive = true
        previousSketch.anchor(top: guessTextField.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0)
        
        canvasBottomBorderView.anchor(top: previousSketch.bottomAnchor,
                                      left: view.safeAreaLayoutGuide.leftAnchor,
                                      bottom: nil,
                                      right: view.safeAreaLayoutGuide.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0,
                                      width: 0,
                                      height: 30)
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
        if time <= 5 {
            timerLabel.textColor = .red
        }
        if time == 0 {
            let passedTimeline = timeline
            let roundTimeline = roundEnded()
            GameController.shared.endRound(withTimeline: roundTimeline)
            resetTimer()
        }
    }
    
 }
 
 // MARK: - MCController Delegate
 
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
 
 // MARK: - GameController Delegate
 
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
