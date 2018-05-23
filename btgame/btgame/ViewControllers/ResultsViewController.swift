//  ResultsViewController.swift
import UIKit

class ResultsViewController: UIViewController {
    var timelines: [Timeline]?
    var currentTimelineIndex = 0
    var tableViews: [UITableView] = []

    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
        //TODO: - disable vertical scrolling
        sv.backgroundColor = UIColor.mainScheme1()
        return sv
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.axis = .horizontal
        sv.backgroundColor = .red
        return sv
    }()
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPageIndicatorTintColor = UIColor.mainHighlight()
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor.mainOffWhite()
    
        return pc
    }()
    let replayButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.mainScheme2()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.mainOffWhite(), for: .normal)
        view.addTarget(self, action: #selector(handleReplay), for: .touchUpInside)
        view.setTitle("Replay", for: .normal)
        return view
    }()
    let exitButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.mainScheme2()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.mainOffWhite(), for: .normal)
        view.setTitle("Exit", for: .normal)
        view.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return view
        
    }()
    let bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainScheme1()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view 
    }()
    let starterTopicLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Starter Topic"
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = UIColor.mainOffWhite()
        view.backgroundColor = UIColor.mainScheme1()
        view.textAlignment = .center
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        guard let timelines = timelines else { return }
        guard let starterText = timelines[0].rounds[0].guess else { return }
        starterTopicLabel.text = starterText
        
        scrollView.delegate = self
        view.backgroundColor = UIColor.mainScheme1()
        
        pageControl.numberOfPages = timelines.count
        //print("Timelines: \(timelines)")
        setup()
    }
    private func setupButtons(){
        if(MCController.shared.isAdvertiser == false) {
            replayButton.isHidden = true
        }
        else {
            replayButton.isHidden = false
        }
    }
    func setup() {
        guard let timelines = timelines else { return }
        view.addSubview(scrollView)
        view.addSubview(starterTopicLabel)
        view.addSubview(bottomBarView)
        bottomBarView.addSubview(pageControl)
        bottomBarView.addSubview(replayButton)
        bottomBarView.addSubview(exitButton)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: starterTopicLabel.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomBarView.topAnchor).isActive = true

        tableViews = setupTableViews(with: timelines)
        putTableViewsIntoStackView()
        scrollView.addSubview(stackView)
        
        starterTopicLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        starterTopicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        starterTopicLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        starterTopicLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
       //set the content size within the stack view
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * CGFloat(timelines.count)).isActive = true
        //stackView.heightAnchor.constraint(equalToConstant: view.frame.height - 70).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomBarView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        
       
        pageControl.centerXAnchor.constraint(equalTo: bottomBarView.centerXAnchor).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: bottomBarView.centerYAnchor).isActive = true

        replayButton.topAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: 13).isActive = true
        replayButton.leadingAnchor.constraint(equalTo: bottomBarView.leadingAnchor, constant: 10).isActive = true
        replayButton.bottomAnchor.constraint(equalTo: bottomBarView.bottomAnchor, constant: -13).isActive = true
        replayButton.widthAnchor.constraint(equalTo: bottomBarView.widthAnchor, multiplier: 0.3).isActive = true

        exitButton.topAnchor.constraint(equalTo: bottomBarView.topAnchor, constant: 13).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: bottomBarView.trailingAnchor, constant: -10).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: bottomBarView.bottomAnchor, constant: -13).isActive = true
        exitButton.widthAnchor.constraint(equalTo: bottomBarView.widthAnchor, multiplier: 0.3).isActive = true


    }
    
    fileprivate func putTableViewsIntoStackView() {
        tableViews.forEach { (tableView) in
            tableView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(tableView)
        }
    }
    fileprivate func setupTableViews(with timelines: [Timeline]) -> [UITableView] {
        
        var tableViews: [UITableView] = []
        for (index, _) in timelines.enumerated() {
            let tableView = UITableView()
            tableView.tag = index
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(GuessTableViewCell.self, forCellReuseIdentifier: Constants.GuessCell)
            tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.ImageCell)
            tableView.allowsSelection = false
            tableViews.append(tableView)
        }
        return tableViews
    }
    @objc private func handleExit(){
        MCController.shared.advertiserAssistant?.stop()
        MCController.shared.currentGamePeers = []
        MCController.shared.playerArray = []
        MCController.shared.peerIDDict = [:]
        navigationController?.popToRootViewController(animated: true)
    }
    @objc private func handleReplay(){
        GameController.shared.startNewGame(players: MCController.shared.playerArray)
        DispatchQueue.main.async {
            let destinationVC = TopicViewController()
            for timeline in GameController.shared.orderedTimelines {
                if timeline.owner == MCController.shared.playerArray[0] {
                    destinationVC.timeline = timeline
                }
            }
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let timelines = timelines else { return UITableViewCell() }
        
        if timelines[tableView.tag].rounds[indexPath.row].isImage {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ImageCell, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            cell.round = timelines[tableView.tag].rounds[indexPath.row]
            
            cell.layoutSubviews()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GuessCell, for: indexPath) as? GuessTableViewCell else { return UITableViewCell() }
            cell.round = timelines[tableView.tag].rounds[indexPath.row]
            
            cell.layoutSubviews()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let timelines = timelines else { return 1 }
        print("Rounds count in timeline: \(timelines[currentTimelineIndex].id) are: \(timelines[currentTimelineIndex].rounds.count)")
        return timelines[currentTimelineIndex].rounds.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let timelines = timelines else { return 60.0 }
        if timelines[tableView.tag].rounds[indexPath.row].isImage {
            return CGFloat(view.frame.width)
        } else {
            return 60.0
        }
    }
}

extension ResultsViewController: UIScrollViewDelegate {
    //TODO: - disable vertical scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let pageWidth = scrollView.bounds.width
//        let pageFraction = scrollView.contentOffset.x / pageWidth
//        pageControl.currentPage = Int(round(pageFraction))
//        currentTimelineIndex = pageControl.currentPage
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(pageFraction))
        currentTimelineIndex = pageControl.currentPage
        guard let timelines = timelines else { return }
        guard let starterText = timelines[currentTimelineIndex].rounds[0].guess else { return }
        starterTopicLabel.text = starterText

    }
}




