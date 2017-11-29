//
//  Error Handling.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/28/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit

enum errorHandling: Error {
    
}


class CalendarError {
    
    static func presentErrorWith(title: String, message: String, buttonTitle: String = "Ok") -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alerAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(alerAction)
        return alertController
        
    }
    
    static func isValid(text: String) -> Bool {
        if text == "" {return false}
        
        let textArray = Array(text.utf8)
        let fourtySix: String.UTF8View.Element = 46
        var newArray: [String.UTF8View.Element] = []
        
        for item in textArray {
            if item == fourtySix {
                print("Match")
                newArray.append(item)
            }
        }
        
        if newArray.count <= 1 {
            return true
        } else {
            return false
        }
    }
    
    
    
}

























