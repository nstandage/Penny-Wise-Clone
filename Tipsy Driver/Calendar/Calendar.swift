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
        CalendarDisplay.setDisplayFor(cell: cell, cellState: cellState, dataSource: dataSource, selectedCellStates: selectedCellStates)
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let dataSource = castDataSource()
        //Case 1: Cell's already selected:
        if dataSource.doesCellStateMatchArray(cellState: cellState, arrayOfStates: selectedCellStates) == true {
            if let entry = dataSource.entriesWith(date: cellState.date) {
                var i = 0
                for state in selectedCellStates {
                    if Helper.removeTimeStamp(fromDate: state.date) == Helper.removeTimeStamp(fromDate: (entry.last?.date)!) {
                        selectedCellStates.remove(at: i)
                    }
                    i += 1
                }
                CalendarDisplay.setDisplayFor(cell: cell!, cellState: cellState, dataSource: dataSource, selectedCellStates: selectedCellStates)
                if selectedCellStates.count == 0 {
                    resetCalendar()
                } else {
                    labelSetup()
                }
            } else {
                return
            }
            // Case 2: Cell isn't selected, but has data
        } else if dataSource.doesCellHaveData(cellState: cellState) == true {
            selectedCellStates.append(cellState)
            CalendarDisplay.setDisplayFor(cell: cell!, cellState: cellState, dataSource: dataSource, selectedCellStates: selectedCellStates)
            labelSetup()
            view.isSelectedCellDataHidden(false)
            view.moreButton.isEnabled = true
            //Case 3: cell isn't selected, nor does it have data
        } else {
            selectedCellStates.append(cellState)
            view.performSegue(withIdentifier: SegueIdentifier.detailSegue.rawValue , sender: nil)
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
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
        print("-----------------------------RESET-------------------")
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
            
            view.monthLabel.font = view.monthLabel.font.withSize(28)
            view.yearLabel.font = view.yearLabel.font.withSize(20)
            
            view.sun.font = view.sun.font.withSize(15)
            view.mon.font = view.mon.font.withSize(15)
            view.tue.font = view.tue.font.withSize(15)
            view.wed.font = view.wed.font.withSize(15)
            view.thu.font = view.thu.font.withSize(15)
            view.fri.font = view.fri.font.withSize(15)
            view.sat.font = view.sat.font.withSize(15)
            
            view.calendarHeightConstraint.priority = UILayoutPriority(rawValue: 1000)
            view.calendarHeightConstraint.constant = 280
            
            view.hoursTextLabel.font = view.hoursTextLabel.font.withSize(20)
            view.tipsTextLabel.font = view.tipsTextLabel.font.withSize(20)
            view.hourlyTextLabel.font = view.hourlyTextLabel.font.withSize(20)

            view.hoursLabel.font = view.hoursLabel.font.withSize(18)
            view.tipsLabel.font = view.tipsLabel.font.withSize(18)
            view.hourlyLabel.font = view.hourlyLabel.font.withSize(18)
            
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



