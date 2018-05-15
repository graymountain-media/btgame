//
//  WelcomeViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Dub n' Doodle"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newGameButton: UIButton = {
        let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(r: 20, g: 150, b: 220)
        button.setTitle("Start New Game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let hostButton: UIButton = {
        let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(r: 20, g: 150, b: 220)
        button.setTitle("Host", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    let joinButton: UIButton = {
        let button = UIButton(type: .system)
//       button.backgroundColor = UIColor(r: 20, g: 150, b: 220)
        button.setTitle("Join", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Views
        view.addSubview(containerView)
        view.addSubview(welcomeLabel)
        
        
        // Contstraints
        setupContainerView()
        setupWelcomeLabel()
        
    }
    
    func setupContainerView() {
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        containerView.addSubview(welcomeLabel)
        
        welcomeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12).isActive = true
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
