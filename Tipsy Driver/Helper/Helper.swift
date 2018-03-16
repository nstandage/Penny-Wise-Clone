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
    
    
    static func isSmallDevice() -> CalendarDeviceClass {
        let screenBounds = UIScreen.main.bounds
        let height = screenBounds.height
        
        switch height {
        case 480: return .iPad
        case 568: return .smallPhone
        default: return .normalPhone
        }
    }
    
    
    
    enum CalendarDeviceClass: String {
        case iPad
        case smallPhone
        case normalPhone
    }
}
