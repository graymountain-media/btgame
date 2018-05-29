//
//  CanvasViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
//    var path = UIBezierPath()
//    var startPoint = CGPoint()
//    var touchPoint = CGPoint()
    var round: Round?
    var timer = Timer()
    var time = GameController.shared.currentGame.timeLimit
    
    
    
    lazy var topicLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainScheme1()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Times New Roman", size: 37)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var canvasView: CanvasView = {
        let cv = CanvasView()
        cv.backgroundColor = .white
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
    
//    lazy var red: UIButton = {
//        let btn = UIButton()
//        btn.backgroundColor = .red
//        btn.addTarget(self.canvasView, action: #selector(CanvasView.changeStrokeColor(_:)), for: .touchUpInside)
//        return btn
//    }()
//    
//    lazy var blue: UIButton = {
//        let btn = UIButton()
//        btn.backgroundColor = .blue
//        btn.addTarget(self.canvasView, action: #selector(CanvasView.changeStrokeColor(_:)), for: .touchUpInside)
//        return btn
//    }()
//    
//    lazy var green: UIButton = {
//        let btn = UIButton()
//        btn.backgroundColor = .green
//        btn.addTarget(self.canvasView, action: #selector(CanvasView.changeStrokeColor(_:)), for: .touchUpInside)
//        return btn
//    }()
//    
//    lazy var yellow: UIButton = {
//        var color = UIColor.yellow.cgColor
//        let btn = UIButton()
//        btn.backgroundColor = .yellow
//        btn.addTarget(self.canvasView, action: #selector(CanvasView.changeStrokeColor(_:)), for: .touchUpInside)
//        return btn
//    }()
//    
//    lazy var orange: UIButton = {
//        var color = UIColor.orange.cgColor
//        let btn = UIButton()
//        btn.backgroundColor = .orange
//        btn.addTarget(self.canvasView, action: #selector(CanvasView.changeStrokeColor(_:)), for: .touchUpInside)
//        return btn
//    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.shared.roundNumberLabelValue += 1
        GameController.shared.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.mainScheme1()
        canvasView.clipsToBounds = true
        canvasView.isMultipleTouchEnabled = false
        canvasView.tag = 1
        
        guard let round = round, let topic = round.guess else {return}
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
        
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
        self.view.addSubview(timerLabel)
        self.view.addSubview(canvasTopBorderView)
        self.view.addSubview(canvasBottomBorderView)
//        self.view.addSubview(orange)
//        self.view.addSubview(red)
//        self.view.addSubview(blue)
//        self.view.addSubview(green)
//        self.view.addSubview(yellow)
        
//        orange.tag = 2
//        yellow.tag = 3
//        red.tag = 4
//        blue.tag = 5
//        green.tag = 6
        
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
        
//        orange.anchor(top: nil,
//                      left: nil,
//                      bottom: canvasView.bottomAnchor,
//                      right: nil,
//                      paddingTop: 0,
//                      paddingLeft: 10,
//                      paddingBottom: 0,
//                      paddingRight: 0,
//                      width: 30,
//                      height: 30)
//
//        red.anchor(top: nil,
//                   left: orange.rightAnchor,
//                   bottom: canvasView.bottomAnchor,
//                   right: nil,
//                   paddingTop: 0,
//                   paddingLeft: 10,
//                   paddingBottom: 0,
//                   paddingRight: 0,
//                   width: 30,
//                   height: 30)
//
//        blue.anchor(top: nil,
//                    left: red.rightAnchor,
//                    bottom: canvasView.bottomAnchor,
//                    right: nil,
//                    paddingTop: 0,
//                    paddingLeft: 10,
//                    paddingBottom: 0,
//                    paddingRight: 0,
//                    width: 30,
//                    height: 30)
//
//        green.anchor(top: nil,
//                     left: blue.rightAnchor,
//                     bottom: canvasView.bottomAnchor,
//                     right: nil,
//                     paddingTop: 0,
//                     paddingLeft: 10,
//                     paddingBottom: 0,
//                     paddingRight: 0,
//                     width: 30,
//                     height: 30)
//
//        yellow.anchor(top: nil,
//                      left: green.rightAnchor,
//                      bottom: canvasView.bottomAnchor,
//                      right: nil,
//                      paddingTop: 0,
//                      paddingLeft: 10,
//                      paddingBottom: 0,
//                      paddingRight: 0,
//                      width: 30,
//                      height: 30)
        
        canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.66).isActive = true
        canvasView.topAnchor.constraint(equalTo: canvasTopBorderView.bottomAnchor, constant: 0).isActive = true
        canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        canvasView.draw(CGRect(x: 0, y: 0, width: canvasView.frame.width, height: canvasView.frame.height))
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
