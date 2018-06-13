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
        case .today, .todayData, .todaySelected: return #imageLiteral(resourceName: "today_circle")
        case .data, .inMonth, .outMonth, .selected: return nil
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
    
    static func displayForSelected(_ cell: JTAppleCell, state: CellState? = nil) {
        if let cellState = state {
            if Helper.removeTimeStamp(fromDate: cellState.date) == Helper.removeTimeStamp(fromDate: Date()) {
                setDisplayForCell(cell: cell, style: .todaySelected)
            } else {
                setDisplayForCell(cell: cell, style: .selected)
            }
        }
        
    }

    static func displayForCell(_ cell: JTAppleCell, cellState: CellState, data: Bool = false, selected: Bool) {
        if cellState.dateBelongsTo != .thisMonth {
            setDisplayForCell(cell: cell, style: .outMonth)
        } else {
            doesCellHaveData(cell: cell, cellState: cellState, data: data)
            isCellToday(cell: cell, cellState: cellState, data: data, selected: selected)
        }
    }
    
    private static func doesCellHaveData(cell: JTAppleCell, cellState: CellState, data: Bool) {
        if data == false {
            setDisplayForCell(cell: cell, style: .inMonth)
        } else {
            setDisplayForCell(cell: cell, style: .data)
        }
    }
    
    private static func isCellToday(cell: JTAppleCell, cellState: CellState, data: Bool, selected: Bool = false) {
        let dateOne = CalendarFormatter.formatWith(date: Date(), style: .fullYear)
        let dateTwo = CalendarFormatter.formatWith(date: cellState.date, style: .fullYear)
        
        if dateOne == dateTwo {
            if data == true && selected != true {
             setDisplayForCell(cell: cell, style: .todayData)
            } else if selected == true {
            
            setDisplayForCell(cell: cell, style: .todaySelected)
           
            } else {
             setDisplayForCell(cell: cell, style: .today)
            }
        } else {
            return
        }
    }
    private static func setDisplayForCell(cell: JTAppleCell, style: CellStyle) {
        
        let calCell = castAppleCellToCalendarCell(cell: cell)
        var isSelected = false
        
        switch style {
        case .outMonth:
            calCell.dateLabel.textColor = CellStyle.outMonth.textColor
            calCell.todayIndicator.image = CellStyle.outMonth.image
        case .inMonth:
            calCell.dateLabel.textColor = CellStyle.inMonth.textColor
            calCell.todayIndicator.image = CellStyle.inMonth.image
        case .data:
            calCell.dateLabel.textColor = Helper.setTextColor()
            calCell.dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
            calCell.todayIndicator.image = CellStyle.data.image
        case .today:
            calCell.dateLabel.textColor = CellStyle.today.textColor
            calCell.todayIndicator.image = CellStyle.today.image
        case .selected:
            calCell.dateLabel.textColor = CellStyle.selected.textColor
            calCell.todayIndicator.image = CellStyle.selected.image
            isSelected = true
        case .todaySelected:
            calCell.dateLabel.textColor = CellStyle.todaySelected.textColor
            calCell.todayIndicator.image = CellStyle.todaySelected.image
            isSelected = true
        case .todayData:
            calCell.dateLabel.textColor = Helper.setTextColor()
            calCell.dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
            calCell.todayIndicator.image = CellStyle.todayData.image
        }
        
        if isSelected == true {
          Helper.setSelectedCircleView(calCell.selectedCircleView)
        } else {
           calCell.selectedCircleView.isHidden = true
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



















