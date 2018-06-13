//
//  IconVC.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class Icon: UIViewController {
    
    enum iconColors: String {
        case blue
        case green
        case red
        case black
        case purpleRed
        case blueGrey
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Icon"
        // Do any additional setup after loading the view.
    }
//UIApplication.shared.setAlternateIconName
    @IBAction func blueIcon() {
        UserDefaults.standard.set("blue", forKey: CalendarDefaults.icon.rawValue)
        changeIcon(iconName: iconColors.blue.rawValue)
        
    }
    
    @IBAction func greenIcon() {
        UserDefaults.standard.set("green", forKey: CalendarDefaults.icon.rawValue)
        changeIcon(iconName: iconColors.green.rawValue)
        
    }
    
    @IBAction func redIcon() {
        UserDefaults.standard.set("red", forKey: CalendarDefaults.icon.rawValue)
        changeIcon(iconName: iconColors.red.rawValue)
        
    }
    
    @IBAction func blackIcon() {
        UserDefaults.standard.set("black", forKey: CalendarDefaults.icon.rawValue)
        changeIcon(iconName: iconColors.black.rawValue)
        
    }
    
    @IBAction func purpleRedIcon() {
        UserDefaults.standard.set("purpleRed", forKey: CalendarDefaults.icon.rawValue)
        changeIcon(iconName: iconColors.purpleRed.rawValue)
        
    }
    
    @IBAction func blueGreyIcon() {
        UserDefaults.standard.set("blueGrey", forKey: CalendarDefaults.icon.rawValue)
        changeIcon(iconName: iconColors.blueGrey.rawValue)
        
    }

    func changeIcon(iconName: String) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
            
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }

}

























