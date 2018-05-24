//
//  SettingsViewController.swift
//  DubNDoodle
//
//  Created by Jake Gray on 5/24/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingSwitch: UISwitch = {
        let sSwitch = UISwitch()
        sSwitch.translatesAutoresizingMaskIntoConstraints = false
        sSwitch.isOn = false
        return sSwitch
    }()
    
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor.mainScheme3()
        return picker
    }()
    
    func setupSwitchCell(){
        contentView.addSubview(settingSwitch)
        contentView.addSubview(titleLabel)
        
        settingSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        settingSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: settingSwitch.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    func setupPickerCell(){
        contentView.addSubview(timePicker)
        contentView.addSubview(titleLabel)
        
        timePicker.anchor(top: contentView.topAnchor, left: nil, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 0)
        
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: timePicker.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
}

class SettingsViewController: UIViewController {
    
    var isAdvertiser: Bool?
    let titles = ["5 sec","10 sec","15 sec","20 sec","25 sec","30 sec"]
    
    let settingsTable: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.rowHeight = 50
        table.backgroundColor = UIColor.mainOffWhite()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.isScrollEnabled = false
        return table
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainScheme2()
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainOffWhite()
        setupView()
    }
    
    func setupView(){
        settingsTable.delegate = self
        settingsTable.dataSource = self
        settingsTable.register(SettingsTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(settingsTable)
        view.addSubview(doneButton)
        
        settingsTable.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func getTimeValue() -> Int {
        guard let cell = settingsTable.cellForRow(at: IndexPath(item: 0, section: 0)) as? SettingsTableViewCell else {return 15}
        
        let timeString = titles[cell.timePicker.selectedRow(inComponent: 0)]
        
        var timeValue = 0
        
        switch timeString{
        case "5 sec":
            timeValue = 5
        case "10 sec":
            timeValue = 10
        case "15 sec":
            timeValue = 15
        case "20 sec":
            timeValue = 20
        case "25 sec":
            timeValue = 25
        case "30 sec":
            timeValue = 30
        default:
            timeValue = 15
        }
        return timeValue
    }
    
    @objc func doneButtonTapped() {
        let timeLimit = getTimeValue()
        Constants.timeLimit = timeLimit
        let destinationVC = RegisterViewController()
        if let isAdvertiser = isAdvertiser {
            destinationVC.isAdvertiser = isAdvertiser
        }
        navigationController?.pushViewController(destinationVC, animated: true)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Game Settings"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingsTableViewCell else {return UITableViewCell()}
        
        switch indexPath.row {
        case 0:
            cell.setupPickerCell()
            cell.titleLabel.text = "Round Time"
            cell.timePicker.dataSource = self
            cell.timePicker.delegate = self

        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titles[row]
    }
}
