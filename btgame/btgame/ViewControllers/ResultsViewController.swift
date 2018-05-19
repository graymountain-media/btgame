//
//  ResultsViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/19/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    
    var timelines: [Timeline]?
    var currentTimelineIndex = 0
    var tableViews: [UITableView] = []
    
    
    let myScrollView: UIScrollView = {
        
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = true
        return sv
    }()
    
    let myStackView: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    
    let myPageControll: UIPageControl = {
        
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = UIColor.red
        pc.currentPage = 1
        pc.pageIndicatorTintColor = UIColor.blue
        return pc
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        guard let timelines = timelines else { return }
        
        tableViews = setupTableViews(with: timelines)
        setupScrollView()
        putTableViewsIntoStackView()
        
        
        
        //        tableView1.delegate = self
        //        tablevView2.delegate = self
        //        tableView3.delegate = self
        //        tableView4.delegate = self
        //        tableView1.dataSource = self
        //        tablevView2.dataSource = self
        //        tableView3.dataSource = self
        //        tableView4.dataSource = self
        //        myScrollView.delegate = self
        
        //       setupScrollView()
    }
        func setupScrollView() {
    
            view.addSubview(myScrollView)
            myScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            myScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            myScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
            putTableViewsIntoStackView()
            
            myScrollView.addSubview(myStackView)
    
            myStackView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
            myStackView.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor).isActive = true
            myStackView.trailingAnchor.constraint(equalTo: myScrollView.trailingAnchor).isActive = true
            myStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
            myStackView.widthAnchor.constraint(equalToConstant: view.frame.width * 4).isActive = true
    
            view.addSubview(myPageControll)
            myPageControll.topAnchor.constraint(equalTo: myStackView.bottomAnchor, constant: 30).isActive = true
            myPageControll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            myPageControll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            myPageControll.widthAnchor.constraint(equalToConstant: 100).isActive = true
    
            //        myStackView.widthAnchor.constraint(equalToConstant: view.frame.width * CGFloat(myStackView.arrangedSubviews.count)).isActive = true
    
        }
    
    fileprivate func putTableViewsIntoStackView() {
        
        for tableView in tableViews {
            myStackView.addSubview(tableView)
        }
        
    }
    
    fileprivate func setupTableViews(with timelines: [Timeline]) -> [UITableView] {
        
        var tableViews: [UITableView] = []
        for (index, _) in timelines.enumerated() {
            let tableView = UITableView()
            tableView.tag = index
            tableView.dataSource = self
            tableView.delegate = self
            tableViews.append(tableView)
        }
        
        return tableViews
    }
    
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let timelines = timelines else { return UITableViewCell() }
        
        if timelines[currentTimelineIndex].rounds[indexPath.row].isImage {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ImageCell, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            cell.round = timelines[currentTimelineIndex].rounds[indexPath.row]
            cell.layoutSubviews()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GuessCell, for: indexPath) as? GuessTableViewCell else { return UITableViewCell() }
            cell.round = timelines[currentTimelineIndex].rounds[indexPath.row]
            cell.layoutSubviews()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let timelines = timelines else { return 1 }
        return timelines[currentTimelineIndex].rounds.count
    }
}

extension ResultsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = view.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        myPageControll.currentPage = Int(round(pageFraction))

}





