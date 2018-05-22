//
//  InstructionsViewController.swift
//  btgame
//
//  Created by Brock Boyington on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.mainScheme3()
    }
    
    lazy var container: UIView = {
        let vc = UIView()
        vc.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/1, height: self.view.frame.height/1)
        vc.backgroundColor = .red
        return vc
    }()
    
    lazy var funLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: self.view.frame.width/8, y: 50, width: self.view.frame.width/6, height: self.view.frame.height/8)
        lbl.text = "More players = More fun!"
        lbl.font = UIFont(name: "Palatino-Roman", size: 50)
        return lbl
    }()
    
    lazy var instructionOneLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: self.view.frame.width/8 , y: self.view.frame.height/6, width: self.view.frame.width/6, height: self.view.frame.height/8)
        lbl.text = "Rule 1: Everybody needs to pick a word out of the 4 supplied options."
        return lbl
    }()
}
