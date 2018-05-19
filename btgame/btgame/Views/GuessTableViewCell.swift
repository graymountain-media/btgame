//
//  GuessTableViewCell.swift
//  btgame
//
//  Created by Seth Danner on 5/18/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class GuessTableViewCell: UITableViewCell {
    
    var round: Round?
    
    
    var playerNameLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "Emily"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(guessLabel)
        
        // set x, y, width, height
        playerNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2)
        playerNameLabel.anchor(top: contentView.topAnchor,
                               left: contentView.leftAnchor,
                               bottom: contentView.bottomAnchor,
                               right: nil,
                               paddingTop: 8,
                               paddingLeft: 16,
                               paddingBottom: -8,
                               paddingRight: 0,
                               width: 0,
                               height: 0)
        
        guessLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2)
        guessLabel.anchor(top: contentView.topAnchor,
                          left: nil,
                          bottom: contentView.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 0,
                          paddingBottom: -8,
                          paddingRight: 16,
                          width: 0,
                          height: 0)
        
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let round = round {
            if !round.isImage {
                playerNameLabel.text = round.owner.displayName
                guessLabel.text = round.guess
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
