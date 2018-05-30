//
//  TimelineViewController.swift
//  DubNDoodle
//
//  Created by Jake Gray on 5/29/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    var timeline: Timeline?
    
    var tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(GuessTableViewCell.self, forCellReuseIdentifier: Constants.GuessCell)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.ImageCell)
        
        setTableView()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let timeline = timeline else { return UITableViewCell() }
        
        if timeline.rounds[indexPath.row].isImage {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ImageCell, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            cell.round = timeline.rounds[indexPath.row]
            
            cell.layoutSubviews()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GuessCell, for: indexPath) as? GuessTableViewCell else { return UITableViewCell() }
            cell.round = timeline.rounds[indexPath.row]
            
            cell.layoutSubviews()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let timeline = timeline else { return 1 }
        
        return timeline.rounds.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let timeline = timeline else { return 105.0 }
        if timeline.rounds[indexPath.row].isImage {
            return CGFloat(view.frame.width)
        } else {
            return 120.0
        }
    }
}
