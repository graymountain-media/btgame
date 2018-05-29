//
//  CanvasView.swift
//  btgame
//
//  Created by Brock Boyington on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    
    var path=UIBezierPath()
    var previousPoint:CGPoint
    var lineWidth:CGFloat=5.0
    var strokeColor = UIColor.black
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override init(frame: CGRect) {
        previousPoint=CGPoint.zero
        super.init(frame: .zero)
        let panGestureRecognizer=UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches=1
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init(coder aDecoder: NSCoder) {
        previousPoint=CGPoint.zero
        super.init(coder: aDecoder)!
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        strokeColor.setStroke()
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
    
    func makeImage(withView view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: (viewWithTag(1)?.bounds.size)!)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        print("\(image)")
        return image
    }
    
    @objc func changeStrokeColor(_ sender: UIButton) {
        switch sender.tag {
        case 2:
            strokeColor = UIColor.orange
        case 3:
            strokeColor = UIColor.yellow
        case 4:
            strokeColor = UIColor.red
        case 5:
            strokeColor = UIColor.blue
        case 6:
            strokeColor = UIColor.green
        default:
            strokeColor = UIColor.black
        }
        
//        path = UIBezierPath()
    }
}


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
