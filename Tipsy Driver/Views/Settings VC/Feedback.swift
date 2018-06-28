//
//  FeedbackVC.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class Feedback: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Send Feedback"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func twitterButton() {
        
        if let twitterUrl = URL(string: "https://twitter.com/nstandage") {
            UIApplication.shared.open(twitterUrl)
        } else {
            //ERROR HANDLING
        }
        
    }
    
    @IBAction func emailButton() {
        if let emailURL = URL(string: "mailto:developer@nathanstandage.com") {
            UIApplication.shared.open(emailURL)
        } else {
            //ERROR HANDLING
        }
    }


}
