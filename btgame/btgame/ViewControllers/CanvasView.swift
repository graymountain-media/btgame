//
//  CanvasView.swift
//  btgame
//
//  Created by Brock Boyington on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CanvasView: UIView {

    var path = UIBezierPath()
    var startPoint = CGPoint()
    var touchPoint = CGPoint()
    var seconds = 3
    
//    lazy var canvasView: UIView = {
//        let cv = UIView()
//        cv.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
//        cv.backgroundColor = .white
//        
//        return cv
//    }()
    
    func makeImage(withView view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: (viewWithTag(1)?.bounds.size)!)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        print("\(image)")
        return image
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: viewWithTag(1)) {
            startPoint = point
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: viewWithTag(1)) {
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
        strokeLayer.lineWidth = 20
        viewWithTag(1)?.layer.addSublayer(strokeLayer)
        viewWithTag(1)?.setNeedsDisplay()

    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
