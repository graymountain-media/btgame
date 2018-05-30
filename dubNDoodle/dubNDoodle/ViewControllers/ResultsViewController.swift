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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        
        setIntialViews()
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        setupPageControl()
    }
    
    func setIntialViews() {
        guard let timelines = timelines else {return}
        let view1 = TimelineViewController()
        
        view1.timeline = timelines[0]
        pages.append(view1)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ResultsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let timelines = timelines else {return UIViewController()}
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                
                return nil
                
            } else {
                
                let view = TimelineViewController()
                view.timeline = timelines[viewControllerIndex - 1]
                index += 1
                return view
                
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let timelines = timelines else {return UIViewController()}
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < timelines.count - 1 {
                
                let view = TimelineViewController()
                view.timeline = timelines[viewControllerIndex + 1]
                index -= 1
                
                return view
            } else {
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl.currentPage = index
    }
}
