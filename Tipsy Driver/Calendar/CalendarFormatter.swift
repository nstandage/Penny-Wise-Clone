//
//  Formatter.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 12/13/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation


enum formatStyle: String {
    case month = "MMMM"
    case year = "yyyy"
    case fullYear = "dd MM yyyy"
    case day = "dd"
    case display = " MMMM dd, yyyy"
}

class CalendarFormatter: DateFormatter {
    
    static func formatWith(date: Date, style: formatStyle) -> String {
        let formatter = DateFormatter()
            formatter.dateFormat = style.rawValue
        let formattedString = formatter.string(from: date)
        
        return formattedString
    }
    
    private static func formatterForDate() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter
    }
    
    static func startDate() -> Date {
        let formatter = formatterForDate()
        return formatter.date(from: "2016 01 01")!
    }
    
    static func endDate() -> Date {
        let formatter = formatterForDate()
        return formatter.date(from: "2021 12 31")!

    }
    
    
    
}
