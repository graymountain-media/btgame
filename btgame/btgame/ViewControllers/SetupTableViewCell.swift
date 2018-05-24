//
//  SetupTableViewCell.swift
//  btgame
//
//  Created by Jake Gray on 5/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class SetupTableViewCell: UITableViewCell {
    
    let playerNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let readyUpIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "check-mark")
        view.isHidden = true
        view.tintColor = UIColor.mainHighlight()
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        self.backgroundColor = UIColor.white
        self.addSubview(playerNameLabel)
        self.addSubview(readyUpIcon)
        
        playerNameLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: readyUpIcon.leftAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        readyUpIcon.anchor(top: self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: self.frame.height, height: 0)
    }
    
    func updateCell(withPlayerName name: String) {
        setupCell()
        playerNameLabel.text = name
    }
    
    func donePressed(){
        readyUpIcon.isHidden = false
    }

}
