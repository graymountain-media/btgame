//
//  BrowserViewController.swift
//  btgame
//
//  Created by Jake Gray on 5/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class BrowserViewController: MCBrowserViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainComplement1()
        navigationController?.navigationBar.barTintColor = UIColor.mainScheme1()
        navigationController?.navigationBar.tintColor = UIColor.mainComplement1()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
