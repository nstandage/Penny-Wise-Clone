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
    
    
    
}
