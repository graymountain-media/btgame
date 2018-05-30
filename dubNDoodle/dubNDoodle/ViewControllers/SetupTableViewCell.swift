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
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    func setupCell() {
//        self.backgroundColor = UIColor.white
//        self.addSubview(playerNameLabel)
//        self.addSubview(readyUpIcon)
//
//        playerNameLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: readyUpIcon.leftAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        readyUpIcon.anchor(top: self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: self.frame.height, height: 0)
//    }
//
//    func createIconView() -> UIImageView {
//        let readyUpIconMold: UIImageView = {
//            let view = UIImageView()
//            view.contentMode = .scaleAspectFit
//            view.image = #imageLiteral(resourceName: "check-mark")
//            view.isHidden = true
//            view.tintColor = UIColor.mainHighlight()
//            return view
//        }()
//        return readyUpIconMold
//    }

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
