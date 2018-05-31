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
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(GuessTableViewCell.self, forCellReuseIdentifier: Constants.GuessCell)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.ImageCell)
        
        setTableView()
        
    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        guard let timeline = timeline else {return}
//        self.parent?.title = "Results For Topic \(timeline.rounds[0].guess)"
//    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Making a cell")
        guard let timeline = timeline else { return UITableViewCell() }
        
        if indexPath.row % 2 != 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ImageCell, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            let round = timeline.rounds[indexPath.row]
            cell.updateCell(withRound: round)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GuessCell, for: indexPath) as? GuessTableViewCell else { return UITableViewCell() }
            let round = timeline.rounds[indexPath.row]
            cell.updateCell(withRound: round)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let timeline = timeline else { return 1 }
        
        return timeline.rounds.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 != 0 {
            return CGFloat(view.frame.width)
        } else {
            return 80.0
        }
    }
}
