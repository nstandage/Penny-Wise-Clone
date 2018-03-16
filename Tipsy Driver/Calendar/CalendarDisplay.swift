//
//  CalendarDisplay.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/17/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar


enum CellStyle {
    case data
    case selected
    case today
    case inMonth
    case outMonth
    case todaySelected
    case todayData
    
    var image: UIImage? {
        switch self {
        case .today, .todayData: return #imageLiteral(resourceName: "today_circle")
        case .selected, .todaySelected: return #imageLiteral(resourceName: "selected_circle")
        case .data, .inMonth, .outMonth: return nil
        }
        
    }
    var textColor: UIColor {
        switch self {
        case .inMonth, .today: return CalendarColors.inMonth
        case .outMonth: return CalendarColors.outMonth
        case .todaySelected: return CalendarColors.today
        case .selected: return CalendarColors.selected
        case .data, .todayData: return CalendarColors.data
        }
    }
}


class CalendarDisplay {
    
    static func displayForSelected(_ cell: JTAppleCell) {
        setDisplayForCell(cell: cell, style: .selected)
    }

    static func displayForCell(_ cell: JTAppleCell, cellState: CellState, data: Bool = false) {
        if cellState.dateBelongsTo != .thisMonth {
            setDisplayForCell(cell: cell, style: .outMonth)
        } else {
            doesCellHaveData(cell: cell, cellState: cellState, data: data)
            isCellToday(cell: cell, cellState: cellState, data: data)
        }
    }

    
    private static func doesCellHaveData(cell: JTAppleCell, cellState: CellState, data: Bool) {
        if data == false {
            setDisplayForCell(cell: cell, style: .inMonth)
        } else {
            setDisplayForCell(cell: cell, style: .data)
        }
        
    }
    
    private static func isCellToday(cell: JTAppleCell, cellState: CellState, data: Bool) {
        let dateOne = CalendarFormatter.formatWith(date: Date(), style: .fullYear)
        let dateTwo = CalendarFormatter.formatWith(date: cellState.date, style: .fullYear)
        
        if dateOne == dateTwo {
            if data == true {
             setDisplayForCell(cell: cell, style: .todayData)
            } else {
            setDisplayForCell(cell: cell, style: .today)
            }
        } else {
            return
        }
    }
    
    private static func setDisplayForCell(cell: JTAppleCell, style: CellStyle) {
        
       let calCell = castAppleCellToCalendarCell(cell: cell)
        switch style {
        case .outMonth:
            calCell.circleImage.image = CellStyle.outMonth.image
            calCell.dateLabel.textColor = CellStyle.outMonth.textColor
        case .inMonth:
            calCell.circleImage.image = CellStyle.inMonth.image
            calCell.dateLabel.textColor = CellStyle.inMonth.textColor
        case .data:
            calCell.circleImage.image = CellStyle.data.image
            calCell.dateLabel.textColor = CellStyle.data.textColor
        case .today:
            calCell.circleImage.image = CellStyle.today.image
            calCell.dateLabel.textColor = CellStyle.today.textColor
        case .selected:
            calCell.circleImage.image = CellStyle.selected.image
            calCell.dateLabel.textColor = CellStyle.selected.textColor
        case .todaySelected:
            calCell.circleImage.image = CellStyle.todaySelected.image
            calCell.dateLabel.textColor = CellStyle.todaySelected.textColor
        case .todayData:
            calCell.circleImage.image = CellStyle.todayData.image
            calCell.dateLabel.textColor = CellStyle.todayData.textColor
        }
    }
    
    
    //HELPER METHODS
    private static func castAppleCellToCalendarCell(cell: JTAppleCell) -> CalendarCell {
        guard let calCell = cell as? CalendarCell else {
            //ERROR HANDLING
            print("Casting apple cell to calendar cell failed")
            fatalError()
        }
        return calCell
    }

    
}
