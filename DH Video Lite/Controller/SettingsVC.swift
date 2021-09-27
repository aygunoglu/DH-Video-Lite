//
//  SettingsVC.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 25.09.2021.
//

import UIKit


class SettingsVC: UITableViewController {
    
    private let cellID = "cellID"
    private let darkModeSwitch: UISwitch = {
        let darkModeSwitch = UISwitch()
        darkModeSwitch.addTarget(self, action: #selector(handleDarkModeSwitch), for: .valueChanged)
        return darkModeSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeManager.register(observer: self)
        
        tableView.backgroundColor = themeManager.theme.portalListBackgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "Dark Mode"
//        cell.textLabel?.textColor = themeManager.theme.type == .dark ? .white : .black
        cell.textLabel?.textColor = themeManager.theme.textColor
        cell.backgroundColor = themeManager.theme.settingsCellColor
        cell.accessoryView = darkModeSwitch
        return cell
    }
    
    @objc func handleDarkModeSwitch() {
        themeManager.toggleTheme()
    }
    
}

extension SettingsVC: Themeable {
    func apply(theme: Theme) {
        tableView.backgroundColor = theme.portalListBackgroundColor
        tableView.separatorColor = theme.separatorColor
        
        darkModeSwitch.onTintColor = theme.switchTintColor
        darkModeSwitch.isOn = theme == .dark
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
