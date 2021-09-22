//
//  SettingsViewController.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 21.09.2021.
//

import UIKit
import SwiftTheme

class SettingsViewController: UITableViewController {
    
    private let cellID = "cellID"
    private let darkModeSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.theme_backgroundColor = GlobalPicker.backgroundColor
        tableView.theme_separatorColor = ["#C6C5C5", "#C6C5C5", "#C6C5C5", "#ECF0F1"]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        darkModeSwitch.addTarget(self, action: #selector(handleDarkModeSwitch), for: .valueChanged)
        
        updateDarkModeSwitch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDarkModeSwitch), name: NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "Dark Mode"
        cell.textLabel?.theme_textColor = GlobalPicker.textColor
        cell.theme_backgroundColor = GlobalPicker.backgroundColor
        cell.accessoryView = darkModeSwitch
        return cell
    }
    
    @objc func handleDarkModeSwitch(_ sender: UISwitch) {
        MyThemes.switchNight(isToNight: sender.isOn)
        print("dark mode switch tapped")
        
    }
    
    @objc func updateDarkModeSwitch( ) {
        darkModeSwitch.isOn = MyThemes.isNight()
    }
    
}
