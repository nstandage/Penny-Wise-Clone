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
        let hours = self.hours(entries: entries)
        let tips = self.tips(entries: entries)

    
        return String(format: "%.2f", tips/hours)
    }
    
    static func hours(entries: [Entry]) -> Double {
        var hours = 0.0
        
        for entry in entries {
            hours += entry.hours
        }
        
        return hours
    }
    
    static func tips(entries: [Entry]) -> Double {
        var tips = 0.0
        
        for entry in entries {
            tips += entry.tips
        }
        
        return tips
    }
    
    
    
    
    
}
