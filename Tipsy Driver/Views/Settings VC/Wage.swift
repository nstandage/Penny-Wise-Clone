//
//  WageVC.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class Wage: UIViewController {

    @IBOutlet weak var wageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Hourly Wage"
        setDefault()
    }
    
    @IBAction func saveButton() {
        if let wage = wageTextField.text {
            if CalendarError.isValid(text: wage) == true {
                let wageNumber = Double(wage)!
                UserDefaults.standard.set(wageNumber, forKey: CalendarDefaults.wageDefault.rawValue)
                view.endEditing(true)
                self.dismiss(animated: true, completion: nil)
            } else {
            CalendarError.presentErrorWith(title: .invalidText, message: .invalidText, view: self)
            }
        } else {
            UserDefaults.standard.set(0.0, forKey: CalendarDefaults.wageDefault.rawValue)
            view.endEditing(true)
        }
        
    }

    func setDefault() {
        if let wage = UserDefaults.standard.object(forKey: CalendarDefaults.wageDefault.rawValue) as? String {
            wageTextField.text = wage
        }
    }



}
