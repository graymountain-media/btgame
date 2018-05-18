//
//  ResultsTestViewController.swift
//  btgame
//
//  Created by Seth Danner on 5/17/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ResultsTestViewController: UIViewController {

    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        

        tableView1.delegate = self
        tablevView2.delegate = self
        tableView3.delegate = self
        tableView4.delegate = self
        tableView1.dataSource = self
        tablevView2.dataSource = self
        tableView3.dataSource = self
        tableView4.dataSource = self
        myScrollView.delegate = self
        
        setupScrollView()
    }

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
    
    let tableView1: UITableView = {
        
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ImageTableViewCell.self, forCellReuseIdentifier: "newCellID")
        return tv
    }()
    
    let tablevView2: UITableView = {
        
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ImageTableViewCell.self, forCellReuseIdentifier: "newCellID")
        return tv
    }()
    
    let tableView3: UITableView = {
        
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ImageTableViewCell.self, forCellReuseIdentifier: "newCellID")
        return tv
    }()
    
    let tableView4: UITableView = {
        
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ImageTableViewCell.self, forCellReuseIdentifier: "newCellID")
        return tv
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

    func setupScrollView() {
        
        view.addSubview(myScrollView)
        myScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        myStackView.addArrangedSubview(tableView1)
        myStackView.addArrangedSubview(tablevView2)
        myStackView.addArrangedSubview(tableView3)
        myStackView.addArrangedSubview(tableView4)
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
    
}

extension ResultsTestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentTimelineIndex = 0
        guard let game = game else { return UITableViewCell() }
        
        if game.timeLines[currentIndex].rounds[indexPath.row].isImage {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newCellID", for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            cell.round = game.timeLines
        } else {
            
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

extension ResultsTestViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = view.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        myPageControll.currentPage = Int(round(pageFraction))
    }
}





