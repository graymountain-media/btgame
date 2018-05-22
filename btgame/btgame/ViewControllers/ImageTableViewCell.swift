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
        label.backgroundColor = UIColor.white
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.mainScheme1()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.borderColor = UIColor.mainScheme1().cgColor
        label.layer.borderWidth = 1.0
        return label
    }()
    
    var sketchImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.mainOffWhite()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        contentView.addSubview(sketchImageView)
        contentView.addSubview(playerNameLabel)
        sketchImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        sketchImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        sketchImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        sketchImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        playerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        playerNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        playerNameLabel.widthAnchor.constraint(equalToConstant: 100.0) .isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 30.0) .isActive = true

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let round = round {
            if round.isImage {
                if let image = round.imageData {
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
