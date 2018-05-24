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
    
    let instructionsTextView: UITextView = {
        let tf = UITextView()
        tf.text = "Objective: To laugh and have fun! \n\n1- Start round: All players select 1 topic for next player to draw. \n\n2- Topics are then randomly passed to another player. \n\n3- Each player will have a set time to draw the topic passed to them. \n\n4- All sketches will then be passed to another player. \n\n5- Everyone will have a set time to guess what their received drawing is. \n\n6- Guesses are then passed to the next player. \n\n7- Repeat steps 3-6 until all sketch and guessing rounds are complete and the final results are shown."
        tf.textColor = UIColor.mainScheme1()
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = UIColor.mainOffWhite()
        tf.isUserInteractionEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.mainScheme2(), for: .normal)
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
    
    func setupContainerView() {
        
        view.addSubview(instructionsTextView)
        view.addSubview(dismissButton)
        
        instructionsTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        instructionsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        instructionsTextView.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -12).isActive = true
        instructionsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    @objc func dismissButtonTapped() {
        
        dismiss(animated: true, completion: nil)
    }
}
