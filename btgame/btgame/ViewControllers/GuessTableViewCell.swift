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
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainScheme1()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.borderColor = UIColor.mainScheme1().cgColor
        label.layer.borderWidth = 1.0
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let guessLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mainOffWhite()
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(guessLabel)
        contentView.addSubview(playerNameLabel)
        
        guessLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        guessLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        guessLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        guessLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        playerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        playerNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        playerNameLabel.widthAnchor.constraint(equalToConstant: 100.0) .isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 30.0) .isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let round = round {
            if !round.isImage {
                self.backgroundColor = UIColor.mainScheme3()
                playerNameLabel.text = round.owner.displayName
                guessLabel.text = round.guess
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
