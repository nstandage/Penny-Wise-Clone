//
//  CalendarView.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 12/13/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.

import Foundation
import JTAppleCalendar
import UIKit


class MyCalendar: JTAppleCalendarView, JTAppleCalendarViewDelegate {
    
    var selectedCellStates: [CellState] = []
    var selectedCells: [JTAppleCell] = []
    var view: ViewController!
    
//    init(view: ViewController) {
//        self.view = view
//        super.init()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//
//        super.init(coder: aDecoder)
//    }

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

    //App Delegate
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        displayFor(cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if let unwrappedCell = cell {
            displayFor(unwrappedCell, cellState: cellState)
        } else {
            print("Cell isn't a cell in didDelectDate")
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        print("deselect")
        if let unwrappedCell = cell {
            displayFor(unwrappedCell, cellState: cellState)
        } else {
            print("Cell isn't a cell in didDeselectDate")
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
    }
    
    
    func displayFor(_ cell: JTAppleCell, cellState: CellState) {
        let data = doesCellHaveData(cellState: cellState)
        CalendarDisplay.displayForCell(cell, cellState: cellState, data: data)
    }
    //Other Methods

    func doesCellHaveData(cellState: CellState) -> Bool {
        guard let dataSource = calendarDataSource as? DataSource else {
            return false
        }
        let bool = dataSource.doesCellHaveData(cellState: cellState)
        return bool
        
    }
    
    func resetCalendar() {
        selectedCells = []
        selectedCellStates = []
        deselectAllDates()
        reloadData()
    }
}





































