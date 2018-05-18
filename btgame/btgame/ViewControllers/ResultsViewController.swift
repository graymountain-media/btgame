//
//  ResultsViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ResultsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let game = Game(players: [], timeLines: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Results"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCellID")
        collectionView?.register(GuessCollectionViewCell.self, forCellWithReuseIdentifier: "guessCellID")
        setupPlayerResultsTabBar()
        
    }
    
    let playerResultsTabBar: PlayerResultsTabBar = {
        
        let pb = PlayerResultsTabBar()
        return pb
    }()
    
    private func setupPlayerResultsTabBar() {
        
        view.addSubview(playerResultsTabBar)
        playerResultsTabBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        playerResultsTabBar.heightAnchor.constraint(equalToConstant: 50)
        playerResultsTabBar.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let round = game.timeLines[0].rounds[indexPath.row]
//        let round = true
        
        if round.isImage == true {
            if round == true {
                // create and return image cell
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellID", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
                cell.playerNameLabel.text = "round.owner.displayName"
                
                if let data = round.imageData {
                    cell.sketchImageView.image = UIImage(data: data)
                } else {
                    cell.sketchImageView.image = UIImage(named: "dinosaurdrawing")
                    
                    return cell
                }
            
            //        return cell
            
        else {
            //create and return guess cell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guessCellID", for: indexPath) as? GuessCollectionViewCell else { return UICollectionViewCell() }
            //    cell.playerNameLabel.text = "round.owner.displayName"
            //    cell.guessLabel.text = "round.guess"
            
            return cell
        }
        
    }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
                let round = game.timeLines[0].rounds[indexPath.row]
                let round = true
                
                if round.isImage == true {
                    if round == true {
                        
                        return CGSize(width: view.frame.width, height: 250)
                        
                    } else {
                        
                        return CGSize(width: view.frame.width, height: 100)
                    }
                }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}
