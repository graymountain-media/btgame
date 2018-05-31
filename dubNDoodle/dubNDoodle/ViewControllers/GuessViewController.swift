 //
 //  GuessViewController.swift
 //  btgame
 //
 //  Created by Jake Gray on 5/15/18.
 //  Copyright © 2018 Jake Gray. All rights reserved.
 //
 
 import UIKit
 import MultipeerConnectivity
 
 class GuessViewController: UIViewController {
    
    var round: Round?
    var timer = Timer()
    var time = Constants.guessTimeLimit
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainScheme1()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let previousSketch: UIImageView = {
        let ps = UIImageView()
        ps.backgroundColor = .white
        ps.contentMode = .scaleAspectFit
        ps.translatesAutoresizingMaskIntoConstraints = false
        return ps
    }()
    
    let guessTextField: UITextField = {
        let gtf = UITextField()
        gtf.backgroundColor = UIColor.mainOffWhite()
        gtf.textColor = .black
        gtf.placeholder = "Enter your dub"
        gtf.layer.borderColor = UIColor.mainScheme1().cgColor
        gtf.layer.borderWidth = 1.0
        gtf.translatesAutoresizingMaskIntoConstraints = false
        gtf.setPadding()
        return gtf
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mainOffWhite()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.mainScheme3().cgColor
        label.layer.cornerRadius = 30
        label.clipsToBounds = true
        return label
    }()
    
    let topLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.mainScheme1()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.font = UIFont.preferredFont(forTextStyle: .title2)
        return lbl
    }()
    
    let guessFieldPaddingView: UIView = {
        let cbv = UIView()
        cbv.backgroundColor = UIColor.mainScheme3()
        cbv.translatesAutoresizingMaskIntoConstraints = false
        return cbv
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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        GameController.shared.delegate = self
        GameController.shared.roundNumberLabelValue += 1
        MCController.shared.exitDelegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.mainScheme1()
        
        setupView()
        setupBarView()
        
        guard let round = round, let data = round.imageData else { return }
        let image = UIImage(data: data)
        previousSketch.image = image
        topLabel.text = "Dub this Doodle"
        timerLabel.text = String(time)
        startTimer()
    }
    
    
    //MARK: - View Setup
    
    func setupView() {
        view.addSubview(barView)
        view.addSubview(previousSketch)
        view.addSubview(guessTextField)
        view.addSubview(guessFieldPaddingView)
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
        
        guessFieldPaddingView.anchor(top: barView.bottomAnchor,
                                   left: view.safeAreaLayoutGuide.leftAnchor,
                                   bottom: nil,
                                   right: view.safeAreaLayoutGuide.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 30)
        
        guessTextField.anchor(top: guessFieldPaddingView.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 44)
        
        canvasTopBorderView.anchor(top: guessTextField.bottomAnchor,
                                   left: view.safeAreaLayoutGuide.leftAnchor,
                                   bottom: nil,
                                   right: view.safeAreaLayoutGuide.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 30)
        
        previousSketch.anchor(top: canvasTopBorderView.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: canvasBottomBorderView.topAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0)
        
        canvasBottomBorderView.anchor(top: nil,
                                      left: view.safeAreaLayoutGuide.leftAnchor,
                                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                      right: view.safeAreaLayoutGuide.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0,
                                      width: 0,
                                      height: 30)
    }
    
    func setupBarView() {
        barView.addSubview(topLabel)
        barView.addSubview(timerLabel)
        
        topLabel.anchor(top: nil,
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
    
    // MARK: Timer
    
    func resetTimer() {
        time = Constants.guessTimeLimit
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
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
 }
 
 
 
 // MARK: - GameController Delegate
 
 extension GuessViewController: GameControllerDelegate {
    func roundEnded() -> Round {
        let newRound = Round(owner: MCController.shared.playerArray[0], image: nil, guess: guessTextField.text, isImage: false)
        return newRound
    }
    
    func advertiserToCanvasView(withRound: Round) {
    }
    func advertiserToGuessView(withRound: Round) {
    }
    func advertiserToResultsView(withTimelines timelines: [Timeline]) {
    }
    
 }
 extension GuessViewController: MCExitGameDelegate {
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
