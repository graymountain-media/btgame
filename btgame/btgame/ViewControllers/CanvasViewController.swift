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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.clipsToBounds = true
        canvasView.isMultipleTouchEnabled = false
        self.view.addSubview(bankrollButton)
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
        self.view.addBackground()
        canvasView.tag = 1
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
        cv.frame = CGRect(x: 0, y: self.view.frame.height/8, width: self.view.frame.width/1, height: self.view.frame.height/3)
        cv.backgroundColor = .white
        cv.draw()
        return cv
    }()
    
    lazy var bankrollButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 132, y: 375, width: 150, height: 50)
        btn.setTitle("Lets count cards", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Times New Roman", size: 20)
        btn.backgroundColor = .gray
        btn.addTarget(self, action: #selector(self.goToNextView(_:)), for: .touchDown)
        return btn
    }()
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        if let point = touch?.location(in: canvasView) {
//            startPoint = point
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        if let point = touch?.location(in: canvasView) {
//            touchPoint = point
//        }
//        path.move(to: startPoint)
//        path.addLine(to: touchPoint)
//        startPoint = touchPoint
//        
//        draw()
//    }
//    
//    func draw() {
//        let strokeLayer = CAShapeLayer()
//        strokeLayer.fillColor = nil
//        strokeLayer.strokeColor = UIColor.black.cgColor
//        strokeLayer.path = path.cgPath
//        canvasView.layer.addSublayer(strokeLayer)
//        canvasView.setNeedsDisplay()
//    }
    
    @objc func goToNextView(_ sender: UIButton) {
        let nextView = GuessViewController()
        self.navigationController?.show(nextView, sender: sender)
    }
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

