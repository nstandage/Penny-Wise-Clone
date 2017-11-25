//
//  CalendarConfiguration.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData


extension ViewController: JTAppleCalendarViewDelegate {

    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell

        cell.dateLabel.text = cellState.text

        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColour(view: cell, cellState: cellState)
        return cell
    }
// moved to Data Source
    
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
            displayForSelectedCell(cell: view!, cellState: cellState)
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
    
    
    func displayForSelectedCell(cell: JTAppleCell, cellState: CellState) {
        //let date = cellState.date

print("CELL SELECTED!!!! ***")

        //let fetch: NSFetchRequest<Entry> = Entry.fetchRequest()
        let fetch = NSFetchRequest<Entry>(entityName: "Entry")
        
        do {
            let fetchedEntries = try manangedObjectContext.fetch(fetch as! NSFetchRequest<NSFetchRequestResult>) as! [Entry]
            print("HELLO::", fetchedEntries)
            
            print("HOURS:::: \(fetchedEntries[1].date!)")
            
            
        } catch {
            fatalError("FAILED GETTING ENTEIRES OUT...")
        }
        
        //        let moc = …
//        let employeesFetch = NSFetchRequest(entityName: "Employee")
//
//        do {
//            let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [EmployeeMO]
//        } catch {
//            fatalError("Failed to fetch employees: \(error)")
//        }
    }
}



