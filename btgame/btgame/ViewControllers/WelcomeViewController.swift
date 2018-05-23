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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.gameName)"
        label.textColor = UIColor.mainScheme2()
        label.textAlignment = .center
        label.font = UIFont(name: "zapfino", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let beginGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("\(Constants.begin)", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitleColor(UIColor.mainComplement1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 35)
        button.layer.cornerRadius = 65
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(beginGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var hostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: beginGameButton.frame.origin.x, y: beginGameButton.frame.origin.y, width: 130, height: 130))
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitleColor(UIColor.mainComplement1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 35)
        button.layer.cornerRadius = 65
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.isHidden = true
        button.addTarget(self, action: #selector(hostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var joinButton: UIButton = {
        let button = UIButton(frame: CGRect(x: beginGameButton.frame.origin.x, y: beginGameButton.frame.origin.y, width: 130, height: 130))
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitleColor(UIColor.mainComplement1(), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 35)
        button.layer.cornerRadius = 65
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.isHidden = true
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let howToPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.mainScheme1(), for: .normal)
        button.setTitle("How to Play", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 20)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(howToPlayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainOffWhite()
        view.addSubview(containerView)
        setupContainerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupContainerView() {
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        containerView.addSubview(welcomeLabel)
        containerView.addSubview(beginGameButton)
        containerView.addSubview(hostButton)
        containerView.addSubview(joinButton)
        containerView.addSubview(howToPlayButton)
        
        welcomeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        welcomeLabel.anchor(top: containerView.topAnchor,
                            left: containerView.leftAnchor,
                            bottom: nil,
                            right: containerView.rightAnchor,
                            paddingTop: 50,
                            paddingLeft: 12,
                            paddingBottom: 0,
                            paddingRight: 12,
                            width: 0,
                            height: 0)
        
        beginGameButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        beginGameButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        beginGameButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        beginGameButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        howToPlayButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        howToPlayButton.anchor(top: nil,
                               left: nil,
                               bottom: containerView.bottomAnchor,
                               right: nil,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: -40,
                               paddingRight: 0,
                               width: 0,
                               height: 0)
    }
    
    @objc func beginGameButtonTapped() {
        
        hostButton.center = beginGameButton.center
        joinButton.center = beginGameButton.center
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.beginGameButton.setTitle("", for: .normal)
        }) { (_) in
            self.beginGameButton.isHidden = true
            self.hostButton.isHidden = false
            self.joinButton.isHidden = false
            UIView.animate(withDuration: 0.75) {
                
                self.joinButton.setTitle("Join", for: .normal)
                self.hostButton.setTitle("Host", for: .normal)
                self.joinButton.frame.origin.x += 85
                self.hostButton.frame.origin.x -= 85
            }
        }
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
