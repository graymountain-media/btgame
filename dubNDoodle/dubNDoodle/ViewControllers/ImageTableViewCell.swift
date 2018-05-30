//
//  ImageTableViewCell.swift
//  btgame
//
//  Created by Seth Danner on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    let letterLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.mainScheme2()
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var playerNameLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainScheme1()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var sketchImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.mainScheme2().cgColor
//        imageView.layer.shadowRadius = 10
//        imageView.layer.shadowColor = UIColor.mainHighlight().cgColor
//        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }

    func setupView() {
        
        contentView.addSubview(sketchImageView)
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(letterLabel)
        
        letterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        letterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        letterLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        letterLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sketchImageView.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 8).isActive = true
        sketchImageView.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 4).isActive = true
        sketchImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        sketchImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        playerNameLabel.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 4).isActive = true
        playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        playerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 30.0) .isActive = true
        
//        if let round = round {
//            if round.isImage {
//                if let image = round.imageData {
//                    self.backgroundColor = UIColor.mainOffWhite()
//                    sketchImageView.image = UIImage(data: image)
//                    playerNameLabel.text = round.owner.displayName
//                    let uppercasedName = round.owner.displayName.uppercased()
//                    let firstLetter = Array(uppercasedName)[0]
//                    letterLabel.text = String(firstLetter)
//                }
//            }
//        }
        
       
    }
    
    func updateCell(withRound round: Round) {
        print("Update image cell")
        if let image = round.imageData {
            self.backgroundColor = UIColor.mainOffWhite()
            sketchImageView.image = UIImage(data: image)
            playerNameLabel.text = round.owner.displayName
            let uppercasedName = round.owner.displayName.uppercased()
            let firstLetter = Array(uppercasedName)[0]
            letterLabel.text = String(firstLetter)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
