//
//  GuessTableViewCell.swift
//  btgame
//
//  Created by Seth Danner on 5/18/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class GuessTableViewCell: UITableViewCell {
    
    let letterLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mainScheme3()
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
        
        setupCell()
    }
    func setupCell() {
        
        contentView.addSubview(letterLabel)
        contentView.addSubview(guessLabel)
        contentView.addSubview(playerNameLabel)
        
        letterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        letterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        letterLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        letterLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        guessLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 8).isActive = true
        guessLabel.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 4).isActive = true
        guessLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        guessLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        playerNameLabel.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 4).isActive = true
        playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        playerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 30.0) .isActive = true
        
    }
    
    func updateCell(withRound round: Round) {
        print("Update guess cell")
            playerNameLabel.text = round.owner.displayName
            guessLabel.text = round.guess
            let uppercasedName = round.owner.displayName.uppercased()
            let firstLetter = Array(uppercasedName)[0]
            letterLabel.text = String(firstLetter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
