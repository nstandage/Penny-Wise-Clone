//
//  Error Handling.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/28/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit

class CalendarError {
    
    static func presentErrorWith(title: ErrorTitle, message: ErrorMessage, buttonTitle: String = "Ok", view: UIViewController) {
        let alertController = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let alerAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(alerAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    static func isValid(text: String, emptyAccepted: Bool = false) -> Bool {
        if text == "" {
            if emptyAccepted == false {
                return false
            } else if emptyAccepted == true {
                return true
            }
        }
        
        let textArray = Array(text.utf8)
        let fourtySix: String.UTF8View.Element = 46
        var newArray: [String.UTF8View.Element] = []
        
        for item in textArray {
            if item == fourtySix {
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


enum ErrorTitle: String {
    case fetchingError = "Fetching Error"
    case segueError = "Segue Error"
    case castingError = "Casting Error"
    case savingError = "Saving Error"
    case invalidText = "Invalid Text"
    case delete = "Delete Entry?"
    case exportError = "Exporting Error"
}

enum ErrorMessage: String {
    case fetching = "Sorry, we're couldn't fetch your data."
    case segue = "Sorry, We couldn't perform segue."
    case casting = "Sorry, we had trouble casting."
    case saving = "Sorry, we had an error saving your data."
    case invalidText = "Sorry, Invalid Text. Please check text and try again."
    case delete = "Delete all entries for selected date?"
    case exportError = "There was a problem exporting your data. Please try again"
}
























