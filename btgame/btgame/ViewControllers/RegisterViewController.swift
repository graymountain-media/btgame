//
//  RegisterViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    let enterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Player Name"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playerNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "  Enter your name here..."
        tf.backgroundColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1.0
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor.black.cgColor
        
        
        return tf
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        
        
        // Views
        view.addSubview(containerView)
        
        
        
        // Contstraints
        setupContainerView()
        
    }
    
    func setupContainerView() {
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        containerView.addSubview(enterNameLabel)
        containerView.addSubview(playerNameTextField)
        containerView.addSubview(submitButton)
        
        enterNameLabel.anchor(top: containerView.topAnchor,
                              left: containerView.leftAnchor,
                              bottom: nil,
                              right: containerView.rightAnchor,
                              paddingTop: 100,
                              paddingLeft: 20,
                              paddingBottom: 0,
                              paddingRight: 20,
                              width: 0,
                              height: 100)
        
        playerNameTextField.anchor(top: enterNameLabel.bottomAnchor,
                                   left: containerView.leftAnchor,
                                   bottom: nil,
                                   right: containerView.rightAnchor,
                                   paddingTop: 50,
                                   paddingLeft: 40,
                                   paddingBottom: 0,
                                   paddingRight: 40,
                                   width: 0,
                                   height: 40)
        
        submitButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        submitButton.anchor(top: playerNameTextField.bottomAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 30,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 150,
                            height: 40)

    }
    
    @objc func submitButtonTapped() {
        guard let name = playerNameTextField.text, !name.isEmpty else {
            print("No name entered")
            return
        }
        MCController.shared.displayName = name
        let destinationVC = SetupViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
        
    }

}
