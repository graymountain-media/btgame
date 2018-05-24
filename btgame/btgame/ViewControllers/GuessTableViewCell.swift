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
//        label.backgroundColor = UIColor.mainOffWhite()
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainScheme1()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let guessLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mainScheme2()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.shadowRadius = 10
        label.layer.shadowColor = UIColor.mainHighlight().cgColor
        label.layer.shadowOpacity = 0.3
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(guessLabel)
        contentView.addSubview(playerNameLabel)
        
        guessLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 8).isActive = true
        guessLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        guessLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        guessLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19).isActive = true
        
        playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        playerNameLabel.widthAnchor.constraint(equalToConstant: 100.0) .isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 30.0) .isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let round = round {
            if !round.isImage {
                self.backgroundColor = UIColor.mainOffWhite()
                playerNameLabel.text = round.owner.displayName
                guessLabel.text = round.guess
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
