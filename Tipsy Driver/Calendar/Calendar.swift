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
    var view: ViewController!

    //App Delegate
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dateLabel.text = cellState.text
        let dataSource = castDataSource()
        if dataSource.doesCellStateMatchArray(cellState: cellState, arrayOfStates: selectedCellStates) == true {
            displayForSelected(cell)
        } else {
            displayFor(cell, cellState: cellState)
        }
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let dataSource = castDataSource()
        if dataSource.doesCellStateMatchArray(cellState: cellState, arrayOfStates: selectedCellStates) == true {
            return
        } else if dataSource.doesCellHaveData(cellState: cellState) == true {
            selectedCellStates.append(cellState)
            CalendarDisplay.displayForSelected(cell!)
            labelSetup()
            view.moreButton.isEnabled = true
        } else {
            selectedCellStates.append(cellState)
            view.performSegue(withIdentifier: SegueIdentifier.detailSegue.rawValue , sender: nil)
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
    }
    
    func displayFor(_ cell: JTAppleCell, cellState: CellState) {
        let source = castDataSource()
        let data = source.doesCellHaveData(cellState: cellState)
        CalendarDisplay.displayForCell(cell, cellState: cellState, data: data)
    }
    
    func displayForSelected(_ cell: JTAppleCell) {
        CalendarDisplay.displayForSelected(cell)
    }
    
    func calendarDidScroll(_ calendar: JTAppleCalendarView) {
        if let date = visibleDates().monthDates.first?.date {
        view.setUpCalendarLabels(date: date)
        } else {
            //FIXME: - Error Handling
            fatalError()
        }
        
        
    }
    
    //Other Methods
    func resetCalendar() {
        view.updateLabels()
        selectedCellStates = []
        deselectAllDates()
        reloadData()
    }
    
    private func castDataSource() -> DataSource {
        return calendarDataSource as! DataSource
    }
    
    private func labelSetup() {
        let dataSource = castDataSource()
        let entries = dataSource.getEntriesMatching(cellStates: selectedCellStates)
        view.updateLabels(tips: Calculate.tips(entries: entries), hours: Calculate.hours(entries: entries), hourly: Calculate.hourly(entries: entries))
    }
}





































