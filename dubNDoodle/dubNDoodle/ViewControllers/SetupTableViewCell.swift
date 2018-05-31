//
//  SetupTableViewCell.swift
//  btgame
//
//  Created by Jake Gray on 5/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class SetupTableViewCell: UITableViewCell {
    
    var readyUpIcon = UIImageView()
    let playerNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func updateCell(withPlayer player: Player) {
        self.textLabel?.text = player.displayName
        
        if player.isReady {
            self.accessoryType = .checkmark
        } else {
            self.accessoryView = .none
        }
    }
    
    func donePressed(){
        readyUpIcon.isHidden = false
    }

}
