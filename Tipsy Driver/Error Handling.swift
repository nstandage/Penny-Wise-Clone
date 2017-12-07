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
    
    static func deleteErrorWith(title: ErrorTitle, message: ErrorMessage, buttonTitleOne: String = "Ok", buttonTitleTwo: String = "Cancel", view: UIViewController) {
        let alerController = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitleOne, style: .default, handler: nil)
        let alertActionTwo = UIAlertAction(title: buttonTitleTwo, style: .cancel, handler: nil)
        alerController.addAction(alertAction)
        alerController.addAction(alertActionTwo)
        view.present(alerController, animated: true, completion: nil)
        
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


enum ErrorTitle: String {
    case fetchingError = "Fetching Error"
    case segueError = "Segue Error"
    case castingError = "Casting Error"
    case savingError = "Saving Error"
    case invalidText = "Invalid Text"
}

enum ErrorMessage: String {
    case fetching = "Sorry, we're couldn't fetch your data."
    case segue = "Sorry, We couldn't perform segue."
    case casting = "Sorry, we had trouble casting."
    case saving = "Sorry, we had an error saving your data."
    case invalidText = "Sorry, Invalid Text. Please check text and try again."
}
























