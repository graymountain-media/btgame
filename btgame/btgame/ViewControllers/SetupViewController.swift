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
    
    let playerTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.mainOffWhite()
        return tableView
    }()
    
    lazy var startButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Start Game", style: UIBarButtonItemStyle.plain, target: self, action: #selector(startGame))
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(cbManager.state == .poweredOff){
            turnOnBluetooth()
        }
        else {
            MCController.shared.delegate = self
            MCController.shared.doneDelegate = self
            cbManager.delegate = self
            setupTableView()
            setTableViewConstraints()
            if(MCController.shared.isAdvertiser){
                MCController.shared.advertiserAssistant?.start()
                self.navigationItem.rightBarButtonItem = startButton
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else {
                let browserVC = (MCController.shared.browser)!
                browserVC.delegate = self
                present(browserVC, animated: true, completion: nil)
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
        playerTableView.dataSource = self
        playerTableView.delegate = self
        playerTableView.register(SetupTableViewCell.self, forCellReuseIdentifier: Constants.playerCellIdentifier)
    }
    
    @objc fileprivate func startGame() {
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
        view.addSubview(playerTableView)
        playerTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
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
        } else if central.state == .poweredOff {
            turnOnBluetooth()
        }
    }
}
extension SetupViewController: MCBrowserViewControllerDelegate {
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        playerTableView.reloadData()
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
        DispatchQueue.main.async {

            if self.doneButtonTappedCounter >= (MCController.shared.currentGamePeers.count - 1) && MCController.shared.currentGamePeers.count >= Constants.requiredNumberOfPlayers  {

                self.startButton.isEnabled = true
            }else {
                self.startButton.isEnabled = false
            }
        }
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        //checks the status of bluetooth enum cases are: poweredOff, poweredOn, resetting, unauthorized, unknown, unsupported
        MCController.shared.currentGamePeers = []
        MCController.shared.playerArray = []
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
        DispatchQueue.main.async {
            self.playerTableView.reloadData()
        }
    }
    
    func incrementDoneButtonCounter() {
        startButtonStatus()
    }
    
    func toCanvasView(timeline: Timeline) {}
    func toGuessView(timeline: Timeline) {}
}

extension SetupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.playerCellIdentifier, for: indexPath) as? SetupTableViewCell else {return UITableViewCell()}
        
        cell.updateCell(withPlayerName: MCController.shared.currentGamePeers[indexPath.row].displayName)
        if indexPath.row == 0 {
            cell.donePressed()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MCController.shared.currentGamePeers.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = UIColor.mainScheme3()
        let playerLabel = UILabel()
        playerLabel.text = "Players"
        playerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let instructionLabel = UILabel()
        instructionLabel.text = "(minimum 3)"
        instructionLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let readyLabel = UILabel()
        readyLabel.text = "Ready"
        readyLabel.textAlignment = .right
        readyLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(playerLabel)
        view.addSubview(instructionLabel)
        view.addSubview(readyLabel)
        
        playerLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 60, height: 0)
        instructionLabel.anchor(top: view.topAnchor, left: playerLabel.rightAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 0)
        readyLabel.anchor(top: view.topAnchor, left: instructionLabel.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        return view
    }
}
extension SetupViewController: DoneButtonDelegate {
    func playerDidPressDone(player: Player) {
        DispatchQueue.main.async {
            print(player.displayName)
            guard let index = MCController.shared.playerArray.index(of: player) else {
                print("Error getting index")
                return}
            guard let cell = self.playerTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SetupTableViewCell else {
                print("Error getting cell")
                return}
            cell.donePressed()
        }
    }
}
