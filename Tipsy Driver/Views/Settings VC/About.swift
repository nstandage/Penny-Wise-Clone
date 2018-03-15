//
//  AboutVC.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class About: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "About"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func JTAppleCalendarButton() {
        if let JTAppleCalendarUrl = URL(string: "https://github.com/patchthecode/JTAppleCalendar") {
            UIApplication.shared.open(JTAppleCalendarUrl, completionHandler: nil)
        }
    }
    
    @IBAction func flaticonButton() {
        if let flaticonURL = URL(string: "https://www.flaticon.com/authors/gregor-cresnar") {
            UIApplication.shared.open(flaticonURL, completionHandler: nil)
        }
    }
}
