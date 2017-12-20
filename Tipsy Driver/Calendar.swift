//
//  CalendarView.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 12/13/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation
import JTAppleCalendar
import UIKit


class MyCalendar: JTAppleCalendarView, JTAppleCalendarViewDelegate {
    
    var selectedCellStates: [CellState] = []
    var selectedCells: [JTAppleCell] = []
    
    //App Delegate
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        displayForCell(cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
    }
    
    enum CellStyle {
        case data
        case selected
        case today
        case inMonth
        case outMonth
        
        var image: UIImage? {
            switch self {
            case .today: return #imageLiteral(resourceName: "Today Circle")
            case .selected: return #imageLiteral(resourceName: "Circle")
            case .data, .inMonth, .outMonth: return nil
            }
            
        }
        var textColor: UIColor {
            switch self {
            case .data: return CalendarColors.data
            case .inMonth: return CalendarColors.inMonth
            case .outMonth: return CalendarColors.outMonth
            case .today: return CalendarColors.today
            case .selected: return CalendarColors.selected
            }
        }
    }


    // DISPLAY CALENDAR
    
    func setTextForCell(_ cell: CalendarCell, cellState: CellState ) {
        cell.dateLabel.text = CalendarFormatter.formatWith(date: cellState.date, style: .day)
    }
    
    ///Sets up calindar spacing
    func SetupCellSpacing() {
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    func displayForCells(_ cells: [JTAppleCell], cellStates: [CellState]) {
        for (cell, state) in zip(cells, cellStates) {
            displayForCell(cell, cellState: state)
        }
    }
    
    func displayForCell(_ cell: JTAppleCell, cellState: CellState) {
        let calCell = castAppleCellToCalendarCell(cell: cell)
        textColorForCell(cell, cellState: cellState)
        circleForCell(cell, cellState: cellState)
        setTextForCell(calCell, cellState: cellState)
    }
    
    //TEXT COLOR METHODS
    func textColorForCell(_ cell: JTAppleCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            textColorForThisMonth(cell: cell, cellState: cellState)
        } else {
            textColorForOutMonth(cell: cell)
        }
    }
    
    func textColorForOutMonth(cell: JTAppleCell) {
        let calCell = castAppleCellToCalendarCell(cell: cell)
        setTextColor(cell: calCell, style: .outMonth)
    }

    
    func textColorForThisMonth(cell: JTAppleCell, cellState: CellState) {
        let calCell = castAppleCellToCalendarCell(cell: cell)
        if cellIsToday(cellState: cellState) == true {
            setTextColor(cell: calCell, style: .today)
        } else if cellHasData(cellState: cellState) == true {
            setTextColor(cell: calCell, style: .data)
        } else {
            setTextColor(cell: calCell, style: .inMonth)
        }
    }
    
    func setTextColor(cell: CalendarCell, style: CellStyle) {
        cell.dateLabel.textColor = style.textColor
    }
    
    
    //CIRCLE FUNTIONS
    func circleForCell(_ cell: JTAppleCell, cellState: CellState) {
        let calCell = castAppleCellToCalendarCell(cell: cell)
        if cellIsToday(cellState: cellState) == true {
            setCircleForCell(cell: calCell, style: .today)
        } else if cellHasData(cellState: cellState) == true {
            setCircleForCell(cell: calCell, style: .selected)
        } else {
            setCircleForCell(cell: calCell, style: .inMonth)
        }
    }
    
    
    func setCircleForCell(cell: CalendarCell, style: CellStyle) {
        cell.circleImage.image = style.image
    }
    
    
    
    //Other Methods
    
    //FIXME: - Finish Method
    func cellHasData(cellState: CellState) -> Bool {
        return false
    }
    
    func cellIsToday(cellState: CellState) -> Bool {
        let dateOne = CalendarFormatter.formatWith(date: Date(), style: .fullYear)
        let dateTwo = CalendarFormatter.formatWith(date: cellState.date, style: .fullYear)
        if dateOne == dateTwo {
            return true
        } else {
            return false
        }
    }
    
    func castAppleCellToCalendarCell(cell: JTAppleCell) -> CalendarCell {
        guard let calCell = cell as? CalendarCell else {
            //ERROR HANDLING
            print("Casting apple cell to calendar cell failed")
            fatalError()
        }
        return calCell
    }
}





































