//
//  InstructionsViewController.swift
//  btgame
//
//  Created by Brock Boyington on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.mainScheme1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.mainOffWhite()
        view.addSubview(dismissButton)
        
        setupDismissButton()
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
    
    func setupDismissButton() {
        
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func dismissButtonTapped() {
        
        dismiss(animated: true, completion: nil)
    }
}
