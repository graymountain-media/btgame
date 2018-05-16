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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        canvasView.isMultipleTouchEnabled = false
        
        //        self.view.addSubview(viewContainer)
        self.view.addSubview(canvasView)
        self.view.addSubview(topicLabel)
    }
    //        let viewContainer: UIView = {
    //            let vc = UIView()
    //            vc.frame = CGRect(x: 0, y: 0, width: 450, height: 700)
    //            vc.backgroundColor = .red
    //            return vc
    //        }()
    //
    let topicLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = (frame: CGRect(x: 100, y: 50, width: , height: 50))
        lbl.text = "Print Topic Here"
        return lbl
    }()
    
    let canvasView: UIView = {
        let cv = UIView()
        cv.frame = CGRect(x: 0, y: 150, width: 450, height: 400)
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


//    var lastPoint = CGPoint.zeroPoint
//    var red: CGFloat = 0.0
//    var green: CGFloat = 0.0
//    var blue: CGFloat = 0.0
//    var brushWidth: CGFloat = 10.0
//    var opacity: CGFloat = 1.0
//    var swiped = false
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


