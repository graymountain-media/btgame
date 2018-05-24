//
//  ImageTableViewCell.swift
//  btgame
//
//  Created by Seth Danner on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    var round: Round?
    
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
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.mainScheme2().cgColor
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowColor = UIColor.mainHighlight().cgColor
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(sketchImageView)
        contentView.addSubview(playerNameLabel)
        sketchImageView.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 8).isActive = true
        sketchImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        sketchImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        sketchImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19).isActive = true
        
        playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        playerNameLabel.widthAnchor.constraint(equalToConstant: 100.0) .isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 30.0) .isActive = true

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let round = round {
            if round.isImage {
                if let image = round.imageData {
                    self.backgroundColor = UIColor.mainOffWhite()
                    sketchImageView.image = UIImage(data: image)
                    playerNameLabel.text = round.owner.displayName
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
