//
//  Calculate.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/27/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation

class Calculate {
    
    static func hourly(entries: [Entry]) -> String {
        let hours = self.hoursForHourlyCalc(entries)
        let tips = self.tipsForHourlyCalc(entries)
        let total = (tips/hours) + userDefault()
        
        return self.format(number: total)
    }
    
     static func hours(entries: [Entry]) -> String {
        var totalHours = 0.0
        
        for entry in entries {
            totalHours += entry.hours
        }
        
        return String(format: "%.2f", totalHours)
        
    }
    
    static func tips(entries: [Entry]) -> String {
        var totalTips = 0.0
        
        for entry in entries {
            totalTips += entry.tips
        }
        
        return self.format(number: totalTips)
    }
    
    static func numberWithEntries(_ entries: [Entry]) -> Double {
        var total = 0.0
        
        for entry in entries {
            total += entry.hours
        }
        
        return total
    }
    
    static func format(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let formattedNumber = formatter.string(from: number as NSNumber) else {
            return ""
        }
        return formattedNumber
    }
    
    private static func hoursForHourlyCalc(_ entries: [Entry]) -> Double {
        var totalHours = 0.0
        
        for entry in entries {
            totalHours += entry.hours
        }
        
        return totalHours
    }
    
    private static func tipsForHourlyCalc(_ entries: [Entry]) -> Double {
        var totalTips = 0.0
        
        for entry in entries {
            totalTips += entry.tips
        }
        
        return totalTips
    }
    private static func userDefault() -> Double {
        if let wage = UserDefaults.standard.object(forKey: CalendarDefaults.wageDefault.rawValue) {
            let wageString = "\(wage)"
            if let wageNumber = Double(wageString) {
                return wageNumber
            } else {
                return 0.0
            }
        } else {
            return 0.0
        }
    }
    
    private static func castAnyToNumber(any: Any) -> Double {
        
        return 9.9
    }
}



















