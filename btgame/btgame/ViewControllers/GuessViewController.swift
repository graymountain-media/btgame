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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(viewContainer)
        self.view.addSubview(previousSketch)
        let passedTimeline = timeline
        guard let data = passedTimeline?.rounds.last?.imageData else { return }
        let image = UIImage(data: data)
        previousSketch.image = image
    }
    
    lazy var viewContainer: UIView = {
        let vc = UIView()
        vc.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/1, height: self.view.frame.height/1)
        vc.backgroundColor = .red
        return vc
    }()
    
    let previousSketch: UIImageView = {
        let ps = UIImageView()
        ps.frame = CGRect(x: 0, y: 100, width: 450, height: 500)
        ps.backgroundColor = .white
        ps.contentMode = .scaleAspectFit
        return ps
    }()
    
    let guessTextField: UITextField = {
        let gtf = UITextField()
        gtf.frame = CGRect(x: 50, y: 600, width: 350, height: 70)
        gtf.backgroundColor = .white
        gtf.textColor = .black
        return gtf
    }()
 }
 
 extension GuessViewController: MCControllerDelegate {
    func toGuessView(timeline: Timeline) {}
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
    func toTopicView(timeline: Timeline) {}
    func toCanvasView(timeline: Timeline) {
        let nextView = CanvasViewController()
        nextView.timeline = timeline
        self.navigationController?.pushViewController(nextView, animated: true)
    }
 }
 
 extension GuessViewController: GameControllerDelegate {
    func roundEnded() -> Timeline {
        let newRound = Round(owner: MCController.shared.playerArray[0], image: nil, guess: guessTextField.text, isImage: false)
        guard let timeline = timeline else { return Timeline(owner: MCController.shared.playerArray[0]) }
        timeline.rounds.append(newRound)
        return timeline
    }
 }
