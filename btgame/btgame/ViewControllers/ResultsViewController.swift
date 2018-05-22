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
        sv.spacing = 20
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
        view.setTitleColor(UIColor.mainOffWhite(), for: .normal)
        view.setTitle("Replay", for: .normal)
        return view
    }()
    let exitButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.mainScheme2()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.setTitleColor(UIColor.mainOffWhite(), for: .normal)
        view.setTitle("Exit", for: .normal)
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainScheme1()
        guard let timelines = timelines else { return }
        pageControl.numberOfPages = timelines.count
        //print("Timelines: \(timelines)")
        setup()
    }
    func setup() {
        guard let timelines = timelines else { return }

        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableViews = setupTableViews(with: timelines)
        putTableViewsIntoStackView()
        scrollView.addSubview(stackView)
        view.addSubview(pageControl)
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
       //set the content size within the stack view
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width * CGFloat(timelines.count)).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height - 150).isActive = true


        pageControl.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
            tableViews.append(tableView)
        }
        return tableViews
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let timelines = timelines else { return UITableViewCell() }
        
        if timelines[tableView.tag].rounds[indexPath.row].isImage {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ImageCell, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            cell.round = timelines[tableView.tag].rounds[indexPath.row]
            cell.backgroundColor = UIColor.white
            cell.layoutSubviews()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GuessCell, for: indexPath) as? GuessTableViewCell else { return UITableViewCell() }
            cell.round = timelines[tableView.tag].rounds[indexPath.row]
            cell.backgroundColor = UIColor.mainScheme3()
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(pageFraction))
        currentTimelineIndex = pageControl.currentPage
    }
}
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        <#code#>
//    }


//        print("timeline 1 count: \(timelines[0].rounds.count)")
//        print("timeline 2 count: \(timelines[1].rounds.count)")
//        print("here be data: \(timelines[0].rounds[0])")
//        print("here be data: \(timelines[0].rounds[1])")
//        print("here be data: \(timelines[0].rounds[2])")
//        print("here be data: \(timelines[0].rounds[3])")
//        print("here be data: \(timelines[0].rounds[4])")
//        print("here be data: \(timelines[1].rounds[0])")
//        print("here be data: \(timelines[1].rounds[1])")
//        print("here be data: \(timelines[1].rounds[2])")
//        print("here be data: \(timelines[1].rounds[3])")
//        print("here be data: \(timelines[1].rounds[4])")





