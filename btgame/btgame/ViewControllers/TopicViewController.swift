//
//  TopicViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    
    let containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    let chooseTopicBelowLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose one below"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "***API***"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "***API***"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thirdChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "***API***"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fourthChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "***API***"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        containerView.addSubview(firstChoiceLabel)
        containerView.addSubview(secondChoiceLabel)
        containerView.addSubview(thirdChoiceLabel)
        containerView.addSubview(fourthChoiceLabel)
        
        chooseTopicBelowLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        chooseTopicBelowLabel.anchor(top: containerView.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 75,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 0)
        
        firstChoiceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        firstChoiceLabel.anchor(top: chooseTopicBelowLabel.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: nil,
                          paddingTop: 150,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 150,
                          height: 0)
        
        secondChoiceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        secondChoiceLabel.anchor(top: firstChoiceLabel.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: nil,
                          paddingTop: 20,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 150,
                          height: 0)
        
        thirdChoiceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        thirdChoiceLabel.anchor(top: secondChoiceLabel.bottomAnchor,
                                 left: nil,
                                 bottom: nil,
                                 right: nil,
                                 paddingTop: 20,
                                 paddingLeft: 0,
                                 paddingBottom: 0,
                                 paddingRight: 0,
                                 width: 150,
                                 height: 0)
        
        fourthChoiceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        fourthChoiceLabel.anchor(top: thirdChoiceLabel.bottomAnchor,
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
