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
        
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
        self.view.addBackground()
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
    
    lazy var canvasView: UIView = {
        let cv = UIView()
        cv.frame = CGRect(x: 0, y: self.view.frame.height/4, width: self.view.frame.width/1, height: self.view.frame.height/2)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: canvasView) {
            startPoint = point
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: canvasView) {
            touchPoint = point
        }
        path.move(to: startPoint)
        path.addLine(to: touchPoint)
        startPoint = touchPoint
        
        draw()
    }
    
    func draw() {
        let strokeLayer = CAShapeLayer()
        strokeLayer.fillColor = nil
        strokeLayer.strokeColor = UIColor.black.cgColor
        strokeLayer.path = path.cgPath
        canvasView.layer.addSublayer(strokeLayer)
        canvasView.setNeedsDisplay()
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

