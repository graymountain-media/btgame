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
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "Emily"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    var sketchImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "dinosaurdrawing")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(sketchImageView)
        
        // set x, y, width, height
        playerNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/4)
        playerNameLabel.anchor(top: contentView.topAnchor,
                               left: contentView.leftAnchor,
                               bottom: contentView.bottomAnchor,
                               right: nil,
                               paddingTop: 8,
                               paddingLeft: 16,
                               paddingBottom: 8,
                               paddingRight: 0,
                               width: 0,
                               height: 0)
        
        sketchImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4)
        sketchImageView.anchor(top: contentView.topAnchor,
                               left: playerNameLabel.rightAnchor,
                               bottom: contentView.bottomAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 16,
                               paddingLeft: 8,
                               paddingBottom: -16,
                               paddingRight: 16,
                               width: 0,
                               height: 0)
        
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
