//
//  ResultsViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ResultsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Results"
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(PictureCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

class PictureCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let userArtistNameLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "(Arist's username)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let topicDrawnLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "(Arist's Topic)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sketchImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "dinosaurdrawing")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let guesserNameLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "(username)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
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
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.text = "(user's guess)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupViews() {
        
        // Subviews
        addSubview(userArtistNameLabel)
        addSubview(topicDrawnLabel)
        addSubview(sketchImageView)
        addSubview(separatorView)
        addSubview(guesserNameLabel)
        addSubview(guessLabel)
        
        // Constraints
        userArtistNameLabel.widthAnchor.constraint(equalTo: sketchImageView.widthAnchor, multiplier: 1/2)
        userArtistNameLabel.anchor(top: self.topAnchor,
                                   left: self.leftAnchor,
                                   bottom: nil,
                                   right: nil,
                                   paddingTop: 16,
                                   paddingLeft: 16,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 40)
        
        topicDrawnLabel.widthAnchor.constraint(equalTo: sketchImageView.widthAnchor, multiplier: 1/2)
        topicDrawnLabel.anchor(top: self.topAnchor,
                                   left: userArtistNameLabel.rightAnchor,
                                   bottom: nil,
                                   right: self.rightAnchor,
                                   paddingTop: 16,
                                   paddingLeft: 8,
                                   paddingBottom: 0,
                                   paddingRight: 16,
                                   width: 0,
                                   height: 40)
        
        sketchImageView.anchor(top: userArtistNameLabel.bottomAnchor,
                               left: self.leftAnchor,
                               bottom: nil,
                               right: self.rightAnchor,
                               paddingTop: 8,
                               paddingLeft: 16,
                               paddingBottom: 0,
                               paddingRight: 16,
                               width: 0,
                               height: 0)
        
        guesserNameLabel.widthAnchor.constraint(equalTo: sketchImageView.widthAnchor, multiplier: 1/2)
        guesserNameLabel.anchor(top: sketchImageView.bottomAnchor,
                                left: self.leftAnchor,
                                bottom: nil,
                                right: nil,
                                paddingTop: 8,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 0,
                                height: 40)
        
        guessLabel.widthAnchor.constraint(equalTo: sketchImageView.widthAnchor, multiplier: 1/2)
        guessLabel.anchor(top: sketchImageView.bottomAnchor,
                          left: guesserNameLabel.rightAnchor,
                          bottom: nil,
                          right: self.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 8,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 40)
        
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
