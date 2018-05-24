//
//  ImageCollectionViewCell.swift
//  btgame
//
//  Created by Seth Danner on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var playerNameLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "Emily"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
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
    
//    let separatorView: UIView = {
//
//        let view = UIView()
//        view.backgroundColor = UIColor.black
//        return view
//    }()
    
    func setupViews() {
        
        // Subviews
        addSubview(playerNameLabel)
        addSubview(sketchImageView)
//        addSubview(separatorView)
        
        // Constraints
        playerNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
        playerNameLabel.anchor(top: self.topAnchor,
                               left: self.leftAnchor,
                               bottom: self.bottomAnchor,
                               right: nil,
                               paddingTop: 8,
                               paddingLeft: 16,
                               paddingBottom: 8,
                               paddingRight: 0,
                               width: 0,
                               height: 0)
        
        sketchImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4)
        sketchImageView.anchor(top: self.topAnchor,
                               left: playerNameLabel.rightAnchor,
                               bottom: self.bottomAnchor,
                               right: self.rightAnchor,
                               paddingTop: 16,
                               paddingLeft: 8,
                               paddingBottom: -16,
                               paddingRight: 16,
                               width: 0,
                               height: 0)
        
//        separatorView.anchor(top: nil,
//                             left: self.leftAnchor,
//                             bottom: self.bottomAnchor,
//                             right: self.rightAnchor,
//                             paddingTop: 0,
//                             paddingLeft: 0,
//                             paddingBottom: 0,
//                             paddingRight: 0,
//                             width: 0,
//                             height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
