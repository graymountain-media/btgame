//
//  InstructionsViewController.swift
//  btgame
//
//  Created by Brock Boyington on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let funLabel: UILabel = {
        let label = UILabel()
        label.text = "More players = More fun!"
        label.textColor = UIColor.mainScheme2()
        label.font = UIFont(name: "HoeflerText-Black", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructionOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Rule 1: Everybody needs to pick a word out of the 4 supplied options."
        label.textColor = UIColor.mainScheme2()
        label.font = UIFont(name: "HoeflerText-Black", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.mainScheme1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 20)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.mainOffWhite()
        view.addSubview(containerView)
        
        setupContainerView()
    }
    
//    lazy var funLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.frame = CGRect(x: self.view.frame.width/8, y: 50, width: self.view.frame.width/6, height: self.view.frame.height/8)
//        lbl.text = "More players = More fun!"
//        lbl.font = UIFont(name: "Palatino-Roman", size: 50)
//        return lbl
//    }()
//
//    lazy var instructionOneLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.frame = CGRect(x: self.view.frame.width/8 , y: self.view.frame.height/6, width: self.view.frame.width/6, height: self.view.frame.height/8)
//        lbl.text = "Rule 1: Everybody needs to pick a word out of the 4 supplied options."
//        return lbl
//    }()
//
    func setupContainerView() {
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        containerView.addSubview(funLabel)
        funLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        funLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        
        containerView.addSubview(instructionOneLabel)
        instructionOneLabel.topAnchor.constraint(equalTo: funLabel.bottomAnchor, constant: 8).isActive = true
        instructionOneLabel.leadingAnchor.constraint(equalTo: funLabel.leadingAnchor).isActive = true
//        instructionOneLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        containerView.addSubview(dismissButton)
        dismissButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func dismissButtonTapped() {
        
        dismiss(animated: true, completion: nil)
    }
}
