//
//  WelcomeViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var beginButtonCenter: CGPoint!
    var hostButtonCenter: CGPoint!
    var joinButtonCenter: CGPoint!
    
    let containerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.gameName)"
        label.textColor = UIColor.mainScheme3()
        label.textAlignment = .center
        label.font = UIFont(name: "zapfino", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let beginGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("\(Constants.begin)", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 30)
        button.layer.cornerRadius = 50
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.shadowOpacity = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(beginGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let hostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("\(Constants.host)", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 30)
        button.layer.cornerRadius = 50
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.shadowOpacity = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(hostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("\(Constants.join)", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "HoeflerText-Black", size: 30)
        button.layer.cornerRadius = 50
        button.layer.shadowRadius = 2.0
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        button.layer.shadowOpacity = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let howToPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("How to Play", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(howToPlayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        
        hostButtonCenter = hostButton.center
        joinButtonCenter = joinButton.center
        
        hostButton.center = beginGameButton.center
        joinButton.center = beginGameButton.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.mainComplement1()
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(containerView)
        
        setupContainerView()
        
    }
    
    func setupContainerView() {
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        containerView.addSubview(welcomeLabel)
        containerView.addSubview(beginGameButton)
        containerView.addSubview(hostButton)
        containerView.addSubview(joinButton)
        containerView.addSubview(howToPlayButton)
        
        welcomeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        welcomeLabel.anchor(top: containerView.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 50,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 0)
        
//        beginGameButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
//        beginGameButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 150).isActive = true
//        beginGameButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        beginGameButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        beginGameButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        beginGameButton.anchor(top: welcomeLabel.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: nil,
                          paddingTop: 35,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 100,
                          height: 100)
        
//        hostButton.centerXAnchor.constraint(equalTo: beginGameButton.centerXAnchor)
        hostButton.anchor(top: beginGameButton.bottomAnchor,
                          left: containerView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 25,
                          paddingLeft: 45,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 100,
                          height: 100)
        
        joinButton.centerXAnchor.constraint(equalTo: beginGameButton.centerXAnchor)
        joinButton.anchor(top: beginGameButton.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: containerView.rightAnchor,
                          paddingTop: 25,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 45,
                          width: 100,
                          height: 100)

        howToPlayButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        howToPlayButton.anchor(top: beginGameButton.bottomAnchor,
                          left: nil,
                          bottom: nil,
                          right: nil,
                          paddingTop: 180,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 150,
                          height: 0)
    }
    
    @objc func beginGameButtonTapped() {
        
        
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
    
    // MARK: FIX pushViewController to be shown
    @objc func howToPlayButtonTapped() {
//        let registerViewController = RegisterViewController()
//        registerViewController.isAdvertiser = true
//        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
