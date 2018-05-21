//
//  SetupViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//


import UIKit
import MultipeerConnectivity
import CoreBluetooth

class SetupViewController: UIViewController {
    
    
    let cbManager = CBCentralManager()
    var doneButtonTappedCounter = 0
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    lazy var startButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Start", style: UIBarButtonItemStyle.plain, target: self, action: #selector(startGame))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(cbManager.state == .poweredOff){
            turnOnBluetooth()
        }
        else {
            MCController.shared.delegate = self
            cbManager.delegate = self
            setupTableView()
            setTableViewConstraints()
            if(MCController.shared.isAdvertiser){
                MCController.shared.advertiserAssistant?.start()
                self.navigationItem.rightBarButtonItem = startButton
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                print("*******IS ADVERTISING************")
            }
            else {
                let browserVC = (MCController.shared.browser)!
                browserVC.delegate = self
                present(browserVC, animated: true, completion: nil)
                print("*******IS BROWSING************")
            }
        }
        
    }
    
    
    
    //MARK: - private functions
    // fileprivate func passTheDataAround()
    fileprivate func turnOnBluetooth() {
        let alertController = UIAlertController(title: "Turn On Bluetooth", message: "Please Turn On Bluetooth to Continue", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.playerCellIdentifier)
    }
    
    @objc fileprivate func startGame() {
        print("Start game tapped")
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
    
    fileprivate func setTableViewConstraints(){
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
}


extension SetupViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth on")
        } else if central.state == .poweredOff {
            turnOnBluetooth()
        }
    }
}
extension SetupViewController: MCBrowserViewControllerDelegate {
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
        print("Done pressed")
        startButtonStatus()
        let string = "counterString"
        let counter = Counter(counter: string)
        do {
            guard let data = DataManager.shared.encodeCounter(counter: counter) else {return}
            try MCController.shared.session.send(data, toPeers: [MCController.shared.peerIDDict[MCController.shared.playerArray[1]]!], with: .reliable)
        } catch let e {
            print("Error sending count: \(e)")
        }
        
    }
    
    fileprivate func startButtonStatus(){
        doneButtonTappedCounter += 1
        print("Done count: \(doneButtonTappedCounter)")
        DispatchQueue.main.async {
            if self.doneButtonTappedCounter >= (MCController.shared.currentGamePeers.count - 1) {
                self.startButton.isEnabled = true
            }else {
                self.startButton.isEnabled = false
            }
        }
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        //checks the status of bluetooth enum cases are: poweredOff, poweredOn, resetting, unauthorized, unknown, unsupported
        navigationController?.popViewController(animated: true)
    }
}

extension SetupViewController: MCControllerDelegate {
    func toResultsView(timelines: [Timeline]) {
        
    }
    
    func toTopicView(timeline: Timeline) {
        DispatchQueue.main.async {
            let destinationVC = TopicViewController()
            destinationVC.timeline = timeline
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        
    }

    func playerJoinedSession() {
        print("player added")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func incrementDoneButtonCounter() {
        startButtonStatus()
    }
    func toCanvasView(timeline: Timeline) {
        
    }
    
    func toGuessView(timeline: Timeline) {
        
    }
}

extension SetupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.playerCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = MCController.shared.currentGamePeers[indexPath.row].displayName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MCController.shared.currentGamePeers.count
    }
}
