//
//  WelcomeViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.gameName)"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Wide", size: 40.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Host", for: .normal)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitleColor(UIColor.mainComplement1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        button.layer.cornerRadius = 5
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitleColor(UIColor.mainComplement1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        button.layer.cornerRadius = 5
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let howToPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.mainScheme1(), for: .normal)
        button.setTitle("How to Play", for: .normal)
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(howToPlayButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainOffWhite()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupViews() {
        view.addSubview(welcomeLabel)
        view.addSubview(hostButton)
        view.addSubview(joinButton)
        view.addSubview(howToPlayButton)
        
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 8).isActive = true
        
        hostButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: view.frame.height / 8).isActive = true
        hostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5 ).isActive = true
        hostButton.heightAnchor.constraint(equalToConstant: 44.0 ).isActive = true
        
        joinButton.topAnchor.constraint(equalTo: hostButton.bottomAnchor, constant: 28.0).isActive = true
        joinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        joinButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5 ).isActive = true
        joinButton.heightAnchor.constraint(equalToConstant:  44.0 ).isActive = true
        
        
        howToPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        howToPlayButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    @objc func hostButtonTapped() {
        let registerViewController = RegisterViewController()
        registerViewController.isAdvertiser = true
        navigationController?.pushViewController(registerViewController, animated: true)
        
    }
    
    @objc func joinButtonTapped() {
        let registerViewController = RegisterViewController()
        registerViewController.isAdvertiser = false
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func howToPlayButtonTapped() {
        
        let instructionsViewController = InstructionsViewController()
        present(instructionsViewController, animated: true, completion: nil)
    }
}
