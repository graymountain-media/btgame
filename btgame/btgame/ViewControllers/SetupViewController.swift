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
            cbManager.delegate = self
            setupTableView()
            
            if(MCController.shared.isAdvertiser){
                MCController.shared.advertiserAssistant.start()
                self.navigationItem.rightBarButtonItem = startButton
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            else {
                let browserVC = (MCController.shared.browser)!
                browserVC.minimumNumberOfPeers = 3
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.playerCellIdentifier)
    }
    
    @objc fileprivate func startGame() {
        print("Start game tapped")
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
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
        //checks the status of bluetooth enum cases are: poweredOff, poweredOn, resetting, unauthorized, unknown, unsupported
        if cbManager.state == .poweredOn {
            print("Bluetooth on")
        } else {
            turnOnBluetooth()
        }
    }
}
