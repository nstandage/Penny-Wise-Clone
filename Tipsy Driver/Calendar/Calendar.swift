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
        dynamicCalendarCellText(cell: cell)
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
            CalendarDisplay.displayForSelected(cell!, state: cellState)
            labelSetup()
            view.isSelectedCellDataHidden(false)
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
    
    // Checks to see if cell has data and then calls display for cell
    func displayFor(_ cell: JTAppleCell, cellState: CellState) {
        let source = castDataSource()
        let data = source.doesCellHaveData(cellState: cellState)
        
        CalendarDisplay.displayForCell(cell, cellState: cellState, data: data, selected: Helper.isDateSelected(selectedStates: selectedCellStates, stateInQuestion: cellState))
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
        view.isSelectedCellDataHidden(true)
        deselectAllDates()
        selectedCellStates = []
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
    
    func dynamicText() {
        
        if Helper.deviceSize() == .iPad {
            view.monthLabel.font = view.monthLabel.font.withSize(20)
            view.yearLabel.font = view.yearLabel.font.withSize(14)
            
            view.hoursTextLabel.font = view.hoursTextLabel.font.withSize(12)
            view.tipsTextLabel.font = view.tipsTextLabel.font.withSize(12)
            view.hourlyTextLabel.font = view.hourlyTextLabel.font.withSize(12)
            
            view.hoursLabel.font = view.hoursLabel.font.withSize(11)
            view.tipsLabel.font = view.tipsLabel.font.withSize(11)
            view.hourlyLabel.font = view.hourlyLabel.font.withSize(11)
            
            view.sun.font = view.sun.font.withSize(11)
            view.mon.font = view.mon.font.withSize(11)
            view.tue.font = view.tue.font.withSize(11)
            view.wed.font = view.wed.font.withSize(11)
            view.thu.font = view.thu.font.withSize(11)
            view.fri.font = view.fri.font.withSize(11)
            view.sat.font = view.sat.font.withSize(11)
            
            view.deleteButton.titleLabel?.font = view.deleteButton.titleLabel?.font.withSize(11)
            view.editButton.titleLabel?.font = view.editButton.titleLabel?.font.withSize(11)
            view.clearButton.titleLabel?.font = view.clearButton.titleLabel?.font.withSize(11)
            
            view.leftGearConstraint.constant = 30
            view.rightReportsConstraint.constant = 30
            
            
        } else if Helper.deviceSize() == .smallPhone {
            
            view.sun.font = view.sun.font.withSize(14)
            view.mon.font = view.mon.font.withSize(14)
            view.tue.font = view.tue.font.withSize(14)
            view.wed.font = view.wed.font.withSize(14)
            view.thu.font = view.thu.font.withSize(14)
            view.fri.font = view.fri.font.withSize(14)
            view.sat.font = view.sat.font.withSize(14)
            
            view.leftGearConstraint.constant = 30
            view.rightReportsConstraint.constant = 30
        }
    }
    
    func dynamicCalendarCellText(cell: CalendarCell) {
        if Helper.deviceSize() == .iPad {
            cell.dateLabel.font = cell.dateLabel.font.withSize(12)
        } else if Helper.deviceSize() == .smallPhone {
            cell.dateLabel.font = cell.dateLabel.font.withSize(14)
        }
    }
}



