//  ResultsViewController.swift
import UIKit

class ResultsViewController: UIViewController {
    
    var timelines: [Timeline]?
    var currentTimelineIndex = 0 {
        didSet{
            for tableView in tableViews {
                tableView.reloadData()
            }
        }
    }
    var tableViews: [UITableView] = []

    let myScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = true
        sv.backgroundColor = .orange
        return sv
    }()
    let myStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.backgroundColor = .red
        return sv
    }()
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPageIndicatorTintColor = UIColor.mainScheme3()
        pc.currentPage = 1
        pc.pageIndicatorTintColor = UIColor.mainHighlight()
        pc.backgroundColor = UIColor.mainComplement1()
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainComplement1()
        guard let timelines = timelines else { return }
        print("timeline 1 count: \(timelines[0].rounds.count)")
        print("timeline 2 count: \(timelines[1].rounds.count)")
        print("here be data: \(timelines[0].rounds[0])")
        print("here be data: \(timelines[0].rounds[1])")
        print("here be data: \(timelines[0].rounds[2])")
        print("here be data: \(timelines[0].rounds[3])")
        print("here be data: \(timelines[0].rounds[4])")
        print("here be data: \(timelines[1].rounds[0])")
        print("here be data: \(timelines[1].rounds[1])")
        print("here be data: \(timelines[1].rounds[2])")
        print("here be data: \(timelines[1].rounds[3])")
        print("here be data: \(timelines[1].rounds[4])")
        pageControl.numberOfPages = timelines.count
        print("Timelines: \(timelines)")
        
        
        setupScrollView()
        
        print("SetupScrollView called")
        
        print("putTableViewsIntoStackView called")
        
    }
    func setupScrollView() {
        guard let timelines = timelines else { return }
        view.addSubview(myScrollView)
        view.addSubview(pageControl)
        tableViews = setupTableViews(with: timelines)
        putTableViewsIntoStackView()
        myScrollView.addSubview(myStackView)
        
        myScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        //myScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        //myScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor).isActive = true
        myScrollView.widthAnchor.constraint(equalToConstant: view.frame.width * CGFloat(timelines.count)).isActive = true
        
        myStackView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
        myStackView.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor, constant: -20).isActive = true
        myStackView.widthAnchor.constraint(equalToConstant: view.frame.width * CGFloat(timelines.count)).isActive = true
        myStackView.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive = true
        myStackView.centerYAnchor.constraint(equalTo: myScrollView.centerYAnchor).isActive = true
        myStackView.leadingAnchor.constraint(equalTo: myScrollView.leadingAnchor).isActive = true
        myStackView.trailingAnchor.constraint(equalTo: myScrollView.trailingAnchor).isActive = true
        
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//        myPageControll.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    fileprivate func putTableViewsIntoStackView() {
        for tableView in tableViews {
            
            myStackView.addArrangedSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: myStackView.topAnchor).isActive = true
             tableView.bottomAnchor.constraint(equalTo: myStackView.bottomAnchor).isActive = true
            guard let timelines = timelines else { return }
            tableView.widthAnchor.constraint(equalTo:myStackView.widthAnchor, multiplier: CGFloat(1 / timelines.count)).isActive = true
        }
    }
    fileprivate func setupTableViews(with timelines: [Timeline]) -> [UITableView] {
        
        var tableViews: [UITableView] = []
        for (index, _) in timelines.enumerated() {
            let tableView = UITableView()
            //tableView.tag = index
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(GuessTableViewCell.self, forCellReuseIdentifier: Constants.GuessCell)
            tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: Constants.ImageCell)
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
        print("Rounds count in timeline: \(timelines[currentTimelineIndex].id) are: \(timelines[currentTimelineIndex].rounds.count)")
        return timelines[currentTimelineIndex].rounds.count
    }
}

extension ResultsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = view.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(pageFraction))
        currentTimelineIndex = pageControl.currentPage
    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        <#code#>
//    }

}





