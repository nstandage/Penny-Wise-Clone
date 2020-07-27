//
//  ThemeVC.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class Theme: UIViewController {
    
    
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var black: UIButton!
    @IBOutlet weak var purpleRed: UIButton!
    @IBOutlet weak var blueGrey: UIButton!
    @IBOutlet weak var trueBlackSwitch: UISwitch!


    
    override func viewDidLoad() {
        
        if UserDefaults.standard.object(forKey: "darkTheme") as! String == "standard" {
            trueBlackSwitch.isOn = false
        } else if UserDefaults.standard.object(forKey: "darkTheme") as! String == "trueBlack" {
            trueBlackSwitch.isOn = true
        } else {
            trueBlackSwitch.isOn = false
        }
        
        
        
        super.viewDidLoad()
        self.navigationItem.title = "Theme"
        // Do any additional setup after loading the view.
    }

    
    
    
    
    @IBAction func blueTheme() {
        UserDefaults.standard.set("blue", forKey: CalendarDefaults.theme.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func greenTheme() {
        UserDefaults.standard.set("green", forKey: CalendarDefaults.theme.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func redTheme() {
        UserDefaults.standard.set("red", forKey: CalendarDefaults.theme.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func blackTheme() {
        UserDefaults.standard.set("black", forKey: CalendarDefaults.theme.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func purpleRedTheme() {
        UserDefaults.standard.set("purpleRed", forKey: CalendarDefaults.theme.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func blueGreyTheme() {
        UserDefaults.standard.set("blueGrey", forKey: CalendarDefaults.theme.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func trueBlackSwitch(_ sender: Any) {
        if trueBlackSwitch.isOn {
            UserDefaults.standard.set("trueBlack", forKey: CalendarDefaults.darkTheme.rawValue)
        } else {
            UserDefaults.standard.set("standard", forKey: CalendarDefaults.darkTheme.rawValue)
        }
        
        
    }
    
    
}
