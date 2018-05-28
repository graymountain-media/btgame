//
//  BetweenRoundViewController.swift
//  DubNDoodle
//
//  Created by Jake Gray on 5/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class BetweenRoundViewController: UIViewController {
    
    enum NextRoundType {
        case canvas
        case guess
        case results
    }
    
    var timer = Timer()
    var time = 3
    var nextRound = NextRoundType.canvas
    var canvasViewController = CanvasViewController()
    var guessViewController = GuessViewController()
    var resultsViewController = ResultsViewController()
    
    let roundLabel: UILabel = {
        let label = UILabel()
        label.text = "Round"
        label.textColor = UIColor.mainOffWhite()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roundNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainOffWhite()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.isHidden = true
        label.textColor = UIColor.mainHighlight()
        label.font = UIFont.boldSystemFont(ofSize: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainScheme1()
        
        GameController.shared.delegate = self
        MCController.shared.delegate = self
        
        roundNumberLabel.text = String(GameController.shared.roundNumberLabelValue)
        setupView()
    }
    
    func setupView() {
        view.addSubview(roundLabel)
        view.addSubview(roundNumberLabel)
        view.addSubview(timeLabel)
        roundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roundLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        roundNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        roundNumberLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: 8).isActive = true
        
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    // MARK: Timer
    
    func resetTimer() {
        time = 3
        timer.invalidate()
        timeLabel.isHidden = true
    }
    
    func startTimer() {
        timeLabel.isHidden = false
        timeLabel.text = String(time)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTicked), userInfo: nil, repeats: true)
    }
    
    @objc private func timerTicked() {
        time -= 1
        timeLabel.text = String(time)
        print(time)
        if time == 0 {
            switch nextRound {
            case .canvas:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(self.canvasViewController, animated: true)
                }
            case .guess:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(self.guessViewController, animated: true)
                }
            case .results:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(self.resultsViewController, animated: true)
                }
            }
            resetTimer()
        }
        
    }
    
    func toNextRound(){
        DispatchQueue.main.async {
            self.startTimer()
        }
    }
}

extension BetweenRoundViewController: GameControllerDelegate {
    func roundEnded() -> Round {
        return Round(owner: MCController.shared.playerArray[0])
    }
    
    func advertiserToCanvasView(withRound: Round) {
        nextRound = .canvas
        canvasViewController.round = withRound
        toNextRound()
    }
    
    func advertiserToGuessView(withRound: Round) {
        nextRound = .guess
        guessViewController.round = withRound
        toNextRound()
    }
    
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
        nextRound = .results
        resultsViewController.timelines = timelines
        toNextRound()
    }
    
    
}

extension BetweenRoundViewController: MCControllerDelegate {
    func playerJoinedSession() {
    }
    
    func incrementDoneButtonCounter() {
    }
    
    func toTopicView(withTopics topics: [String]) {
    }
    
    func toCanvasView(round: Round) {
        nextRound = .canvas
        canvasViewController.round = round
        toNextRound()
    }
    
    func toGuessView(round: Round) {
        nextRound = .guess
        guessViewController.round = round
        toNextRound()
    }
    
    func toResultsView(timelines: [Timeline]) {
        nextRound = .results
        resultsViewController.timelines = timelines
        toNextRound()
    }
    
    
}
