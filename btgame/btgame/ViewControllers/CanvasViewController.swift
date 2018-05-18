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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.clipsToBounds = true
        canvasView.isMultipleTouchEnabled = false
        self.view.addSubview(testSegueButton)
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
        self.view.addBackground()
        canvasView.tag = 1
//        GameController.shared.startTimer()
    }
    
    lazy var topicLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: self.view.frame.width/4, y: self.view.frame.height/8, width: self.view.frame.width/2, height: self.view.frame.height/16)
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 15.0
        lbl.text = "selectedTopic"
        lbl.textAlignment = .center
        lbl.textColor = .red
        
        return lbl
    }()
    
    lazy var canvasView: CanvasView = {
        let cv = CanvasView()
        cv.frame = CGRect(x: 0, y: 150, width: 300, height: 300)
        cv.backgroundColor = .white
        cv.draw()
        return cv
    }()
    
    lazy var testSegueButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 132, y: 450, width: 150, height: 50)
        btn.setTitle("perform segue", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Times New Roman", size: 20)
        btn.backgroundColor = .white
//        btn.addTarget(self, action: #selector(self.goToNextView(_:)), for: .touchDown)
        return btn
    }()
    
//    @objc func goToNextView(_ sender: Any) {
//        let nextView = GuessViewController()
//        nextView.previousSketch.image = canvasView.makeImage(withView: canvasView)
//        self.navigationController?.show(nextView, sender: sender)
//    }
}

extension UIView {
    func addBackground() {
        let width = self.frame.width/1
        let height = self.frame.height/1
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "Background")
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
}

extension CanvasViewController: MCControllerDelegate {
    func toCanvasView(timeline: Timeline) {}
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
    func toTopicView(timeline: Timeline) {}
    func toGuessView(timeline: Timeline) {
        let nextView = GuessViewController()
        nextView.timeline = timeline
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}

extension CanvasViewController: GameControllerDelegate {
    func roundEnded() -> Timeline {
        let newRound = Round(owner: MCController.shared.playerArray[0], image: canvasView.makeImage(withView: canvasView), guess: nil, isImage: true)
        guard let timeline = timeline else { return Timeline(owner: MCController.shared.playerArray[0]) }
        timeline.rounds.append(newRound)
        return timeline
    }
}
