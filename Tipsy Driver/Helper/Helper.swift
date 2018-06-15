//
//  Helper.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 12/13/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import JTAppleCalendar

class Helper {
    
    static func stringFromNumber(_ number: Double) -> String {
        return String("\(number)")
    }
    
    static func convertEntryToObject(entry: Entry) -> NSManagedObject {
    return entry as NSManagedObject
    }
    
    static func convertStringToNSNumber(numberAsString: String) -> NSNumber {
        let numberAsDouble = NSString(string: numberAsString).doubleValue
        return NSNumber.init(value: numberAsDouble)
    }
    
    static func removeTimeStamp(fromDate: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
    
    static func deviceSize() -> CalendarDeviceClass {
        let screenBounds = UIScreen.main.bounds
        let height = screenBounds.height
        
        switch height {
        case 480: return .iPad
        case 568: return .smallPhone
        case 812: return .iPhoneX
        default: return .normalPhone
        }
    }
    
    static func ChangeTheme(topView: UIView, otherView: UIView? = nil, buttonView: UIView? = nil) {
        var theme: CalendarThemeColors = .blue
        if let themeString = UserDefaults.standard.object(forKey: "theme") as? String {
            switch themeString {
            case "blue": theme = .blue
            case "green": theme = .green
            case "red": theme = .red
            case "black": theme = .black
            case "purpleRed": theme = .purpleRed
            case "blueGrey": theme = .blueGrey
            default: print("Problem with color Theme")
            }
        }
        topView.backgroundColor = theme.color
        if otherView != nil {
            otherView?.backgroundColor = theme.color
        }
        if buttonView != nil {
            buttonView?.backgroundColor = theme.color
        }
    }
    
    static func setSelectedCircleView(_ view: UIView) {
        view.layer.cornerRadius = (view.frame.size.height) / 2
        guard let themeString = UserDefaults.standard.object(forKey: "theme") as? String else {
            view.backgroundColor = CalendarThemeColors.blue.color
            return
        }
            view.isHidden = false
            switch themeString {
            case "blue": view.backgroundColor = CalendarThemeColors.blue.color
            case "green": view.backgroundColor = CalendarThemeColors.green.color
            case "red": view.backgroundColor = CalendarThemeColors.red.color
            case "black": view.backgroundColor = CalendarThemeColors.black.color
            case "purpleRed": view.backgroundColor = CalendarThemeColors.purpleRed.color
            case "blueGrey": view.backgroundColor = CalendarThemeColors.blueGrey.color
            default: view.backgroundColor = CalendarThemeColors.blue.color
            }
    }

    static func setTextColor() -> UIColor {
        let color: UIColor
        guard let themeString = UserDefaults.standard.object(forKey: "theme") as? String else {
            return CalendarThemeColors.blue.color
        }
    
        switch themeString {
        case "blue": color = CalendarThemeColors.blue.color
        case "green": color = CalendarThemeColors.green.color
        case "red": color = CalendarThemeColors.red.color
        case "black": color = CalendarThemeColors.black.color
        case "purpleRed": color = CalendarThemeColors.purpleRed.color
        case "blueGrey": color = CalendarThemeColors.blueGrey.color
        default: color = CalendarThemeColors.blue.color
        }
        return color
    }
    
    enum CalendarDeviceClass: String {
        case iPad
        case smallPhone
        case normalPhone
        case iPhoneX
    }
    
    static func isDateSelected(selectedStates:[CellState], stateInQuestion: CellState ) -> Bool {
        
        for state in selectedStates {

            if removeTimeStamp(fromDate: state.date) == removeTimeStamp(fromDate: stateInQuestion.date) {
                return true
            }
        }
        return false
    }
}







