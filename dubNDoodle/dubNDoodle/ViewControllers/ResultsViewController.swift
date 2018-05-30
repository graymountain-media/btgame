//
//  ResultsViewController.swift
//  DubNDoodle
//
//  Created by Jake Gray on 5/29/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ResultsViewController: UIPageViewController {
    
    var pages: [UIViewController] = []
    let pageControl = UIPageControl()
    let initialPage = 0
    var timelines: [Timeline]?
    var index = 0
    
    lazy var exitButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Exit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(exitButtonPressed))
        return button
    }()
    
    lazy var replayButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Replay", style: UIBarButtonItemStyle.plain, target: self, action: #selector(replayButtonPressed))
        return button
    }()
    
    lazy var noButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        return button
    }()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        MCController.shared.delegate = self
        
        self.view.backgroundColor = UIColor.mainScheme1()
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.rightBarButtonItem = exitButton
        if MCController.shared.isAdvertiser {
            navigationItem.leftBarButtonItem = replayButton
        } else {
            navigationItem.leftBarButtonItem = noButton
        }
        
        
        
        createPages()
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        setupPageControl()
    }
    
    func createPages() {
        guard let timelines = timelines else {return}
        for timeline in timelines {
            let view = TimelineViewController()
            view.timeline = timeline
            pages.append(view)
        }
        
    }
    
    private func setupPageControl(){
        guard let timelines = timelines else {return}
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.mainHighlight()
        pageControl.pageIndicatorTintColor = UIColor.mainScheme2()
        pageControl.currentPage = initialPage
        pageControl.numberOfPages = timelines.count
        
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    @objc private func exitButtonPressed(){
        MCController.shared.advertiserAssistant?.stop()
        MCController.shared.currentGamePeers = []
        MCController.shared.playerArray = []
        MCController.shared.peerIDDict = [:]
        MCController.shared.session.disconnect()
        GameController.shared.clearData()
        MCController.shared.advertiser?.stopAdvertisingPeer()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func replayButtonPressed(){
        GameController.shared.clearData()
        GameController.shared.startNewGame(players: MCController.shared.playerArray)
        
        DispatchQueue.main.async {
            let destinationVC = TopicViewController()
            for timeline in GameController.shared.orderedTimelines {
                if timeline.owner == MCController.shared.playerArray[0] {
                    destinationVC.topics = timeline.possibleTopics
                }
            }
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

}
extension ResultsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return nil
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

extension ResultsViewController: MCControllerDelegate {
    func toTopicView(withTopics topics: [String]) {
        DispatchQueue.main.async {
            print("Results to topic")
            let destinationVC = TopicViewController()
            destinationVC.topics = topics
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func toResultsView(timelines: [Timeline]) {
    }
    
    func toCanvasView(round: Round) {
    }
    
    func toGuessView(round: Round) {
    }
    
    func playerJoinedSession() {}
    func incrementDoneButtonCounter() {}
    
    
    
}
