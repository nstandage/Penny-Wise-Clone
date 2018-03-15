//
//  SettingsViewController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 3
        case 1: return 1
        case 2: return 2
        default:
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segueName = ""
        if indexPath.section == 0 {
           
            switch indexPath.row {
            case 0: segueName = SegueIdentifier.settingsTheme.rawValue
            case 1: segueName = SegueIdentifier.settingsIcon.rawValue
            case 2: segueName = SegueIdentifier.settingsHourlyWage.rawValue
            default: fatalError("Out of Bounds Section 0")
            }
            
            
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0: segueName = SegueIdentifier.settingsTipDeveloper.rawValue
            default: fatalError("Out of Bounds. Section 1")
            }
            
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0: segueName = SegueIdentifier.settingsSendFeedback.rawValue
            case 1: segueName = SegueIdentifier.settingsAbout.rawValue
            default: fatalError("Out of Bounds. Section 2")
            }
        }
        performSegue(withIdentifier: segueName, sender: nil)
    }

}
























