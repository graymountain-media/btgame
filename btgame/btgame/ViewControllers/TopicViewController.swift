//
//  TopicViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    
    var displayName: String?
    
    let containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    let chooseTopicBelowLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose one below"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Topic", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Topic", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let thirdChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Topic", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let fourthChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Topic", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Views
        view.addSubview(containerView)
        
        
        
        // Contstraints
        setupContainerView()
    }
    
    func setupContainerView() {
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        containerView.addSubview(chooseTopicBelowLabel)
        containerView.addSubview(firstChoiceButton)
        containerView.addSubview(secondChoiceButton)
        containerView.addSubview(thirdChoiceButton)
        containerView.addSubview(fourthChoiceButton)
        
        chooseTopicBelowLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        chooseTopicBelowLabel.anchor(top: containerView.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 100,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 0)
        
        firstChoiceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        firstChoiceButton.anchor(top: chooseTopicBelowLabel.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: nil,
                          paddingTop: 100,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 150,
                          height: 0)
        
        secondChoiceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        secondChoiceButton.anchor(top: firstChoiceButton.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: nil,
                          paddingTop: 20,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 150,
                          height: 0)
        
        thirdChoiceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        thirdChoiceButton.anchor(top: secondChoiceButton.bottomAnchor,
                                 left: nil,
                                 bottom: nil,
                                 right: nil,
                                 paddingTop: 20,
                                 paddingLeft: 0,
                                 paddingBottom: 0,
                                 paddingRight: 0,
                                 width: 150,
                                 height: 0)
        
        fourthChoiceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        fourthChoiceButton.anchor(top: thirdChoiceButton.bottomAnchor,
                                 left: nil,
                                 bottom: nil,
                                 right: nil,
                                 paddingTop: 20,
                                 paddingLeft: 0,
                                 paddingBottom: 0,
                                 paddingRight: 0,
                                 width: 150,
                                 height: 0)
    }
    
}
