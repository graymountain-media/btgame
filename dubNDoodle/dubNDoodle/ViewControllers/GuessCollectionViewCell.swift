//
//  GuessCollectionViewCell.swift
//  btgame
//
//  Created by Seth Danner on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class GuessCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let playerNameLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "(Player's Name)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    let separatorView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let guessLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "(Player's Guess)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    
    func setupViews() {
        
        // Subviews
        addSubview(playerNameLabel)
        addSubview(guessLabel)
        addSubview(separatorView)
        
        // Constraints
        playerNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2)
        playerNameLabel.anchor(top: self.topAnchor,
                                   left: self.leftAnchor,
                                   bottom: self.bottomAnchor,
                                   right: nil,
                                   paddingTop: 8,
                                   paddingLeft: 16,
                                   paddingBottom: -8,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 0)
        
        guessLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2)
        guessLabel.anchor(top: self.topAnchor,
                          left: nil,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 0,
                          paddingBottom: -8,
                          paddingRight: 16,
                          width: 0,
                          height: 0)
        
        separatorView.anchor(top: nil,
                             left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
