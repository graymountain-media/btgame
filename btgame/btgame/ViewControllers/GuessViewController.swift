 //
//  GuessViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {

    var image = UIImage()
    static let shared = GuessViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(viewContainer)
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
        return ps
    }()
}
