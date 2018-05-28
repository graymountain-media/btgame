//
//  CanvasView.swift
//  btgame
//
//  Created by Brock Boyington on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
//
class CanvasView: UIView {

//    import UIKit
    
//    class DrawableView: UIView {

        let path=UIBezierPath()
        var previousPoint:CGPoint
        var lineWidth:CGFloat=5.0
        var strokeColor = UIColor.black.cgColor
        // Only override drawRect: if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override init(frame: CGRect) {
            previousPoint=CGPoint.zero
            super.init(frame: frame)
        }
    
        required init(coder aDecoder: NSCoder) {
            previousPoint=CGPoint.zero
            super.init(coder: aDecoder)!
            let panGestureRecognizer=UIPanGestureRecognizer(target: viewWithTag(1), action: #selector(pan))
            panGestureRecognizer.maximumNumberOfTouches=1
            self.addGestureRecognizer(panGestureRecognizer)
            
        }
    
        override func draw(_ rect: CGRect) {
            // Drawing code
            UIColor.green.setStroke()
            path.stroke()
            path.lineWidth=lineWidth
        }
    
        @objc func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void
        {
            let currentPoint=panGestureRecognizer.location(in: self)
            let midPoint=self.midPoint(p0: previousPoint, p1: currentPoint)
            
            if panGestureRecognizer.state == .began
            {
                path.move(to: currentPoint)
            }
            else if panGestureRecognizer.state == .changed
            {
                path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
            }
            
            previousPoint=currentPoint
            self.setNeedsDisplay()
        }
    
        func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint
        {
            let x=(p0.x+p1.x)/2
            let y=(p0.y+p1.y)/2
            return CGPoint(x: x, y: y)
        }
    
//    @objc func draw() {
//        let strokeLayer = CAShapeLayer()
//        path.stroke()
//        strokeLayer.fillColor = nil
//        strokeLayer.strokeColor = strokeColor
//        strokeLayer.path = path.cgPath
//        strokeLayer.lineWidth = 6
//        viewWithTag(1)?.layer.addSublayer(strokeLayer)
//        viewWithTag(1)?.setNeedsDisplay()
//    }
    
}

//@objc func changeStrokeColor(_ sender: UIButton) {
//    switch sender.tag {
//    case 2:
//        strokeColor = UIColor.orange.cgColor
//    case 3:
//        strokeColor = UIColor.yellow.cgColor
//    case 4:
//        strokeColor = UIColor.red.cgColor
//    case 5:
//        strokeColor = UIColor.blue.cgColor
//    case 6:
//        strokeColor = UIColor.green.cgColor
//    default:
//        strokeColor = UIColor.black.cgColor
//    }
//}

//    var path = UIBezierPath()
//    var startPoint = CGPoint()
//    var touchPoint = CGPoint()
//    var seconds = 3
//    var swiped = false
//
//    func makeImage(withView view: UIView) -> UIImage? {
//        let renderer = UIGraphicsImageRenderer(size: (viewWithTag(1)?.bounds.size)!)
//        let image = renderer.image { ctx in
//            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//        }
//        print("\(image)")
//        return image
//    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        swiped = false
//        let touch = touches.first
//        if let point = touch?.location(in: viewWithTag(1)) {
//            startPoint = point
//        }
//    }

//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        swiped = true
//        let touch = touches.first
//        if let point = touch?.location(in: viewWithTag(1)) {
//            touchPoint = point
//        }
//        path.move(to: startPoint)
//        path.addLine(to: touchPoint)
//        startPoint = touchPoint
//
//        draw()
//    }

//}

//extension UIView {
//
//     static func scaleImageToSize(img: UIView) -> UIView {
//        viewWithTag(1).updateConstraints(
//        let size = CGSize(width: 200, height: 200)
//
//        img.draw(in: CGRect(origin: CGPoint.zero, size: size))
//
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext()
//
//        return scaledImage!
//    }
//}
