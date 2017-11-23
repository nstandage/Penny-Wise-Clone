//
//  CalendarConfiguration.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit
import JTAppleCalendar






extension ViewController: JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        guard let startDate = formatter.date(from: "2016 01 01"), let endDate = formatter.date(from: "2019 12 31") else {
            print("Formatter couldn't create dates")
            fatalError()
        }
        
        let parameters = ConfigurationParameters.init(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
}


extension ViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupCalendarView()
    }
}


extension ViewController {
    
    ///Brings view to current day
    @objc func todayView(animated: Bool = true) {
        
        calendarView.scrollToDate(Date(), animateScroll: animated)
        let currentDate: [Date] = [Date()]
        calendarView.selectDates(currentDate)
    }
    
    
    ///Sets up calindar spacing and visible dates
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    ///Sets the month and year labels
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        yearLabel.text = self.formatter.string(from: date)
        yearLabel.textColor = CalendarColors.white
        
        self.formatter.dateFormat = "MMMM"
        monthLabel.text = self.formatter.string(from: date)
        monthLabel.textColor = CalendarColors.white
    }
    
    
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? CalendarCell else { return }
        selectedCellState = cellState
        if cellState.isSelected {
            cell.selectedView.isHidden = false
            cell.dateLabel.textColor = CalendarColors.white
        } else {
            cell.selectedView.isHidden = true
            cell.dateLabel.textColor = CalendarColors.darkGrey
        }
    }
    
    func handleCellTextColour(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? CalendarCell else { return }
        
        if cellState.isSelected {
            cell.selectedView.isHidden = false
            cell.dateLabel.textColor = CalendarColors.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                cell.dateLabel.textColor = CalendarColors.darkGrey
            } else {
                cell.dateLabel.textColor = CalendarColors.lightGrey
            }
            
        }
    }
}



