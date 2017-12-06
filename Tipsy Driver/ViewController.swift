//
//  ViewController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/21/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.

import UIKit
import JTAppleCalendar
import CoreData
import Foundation

class ViewController: UIViewController, JTAppleCalendarViewDelegate {
    
    //Outlets
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    
    //Variables
    let managedObjectContext = CoreDataStack().managedObjectContext
    var selectedCellState: [CellState] = []
    var selectedCell: [JTAppleCell] = []
    let formatter = DateFormatter()
    
    lazy var dataSource: DataSource = {
        return DataSource(context: self.managedObjectContext, formatter: self.formatter, calendar: self.calendarView)
    }()
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.calendarDataSource = dataSource
        setupCalendarView()
        updateLabels()
        moreButton.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.scrollToToday))
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(tap)
        loadTodayView()
    }
    
    
    //FIXME: - TOO LONG
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            guard let newView = segue.destination as? detailViewController else {
                CalendarError.presentErrorWith(title: ErrorTitle.segueError, message: ErrorMessage.segue, view: self)
                return
            }
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            let formattedString = formatter.string(from: (selectedCellState.last?.date)!)
            newView.managedObjectContext = managedObjectContext
            newView.cellState = selectedCellState.last
            newView.dateString = formattedString
            newView.calendarView = calendarView
            newView.viewController = self
        } else if segue.identifier == "moreButtonSegue" {
            
            let destinationNavigationController = segue.destination as! UINavigationController
//            let targetController = destinationNavigationController.topViewController
            
            guard let newView = destinationNavigationController.topViewController as? moreTableViewController else {
                print("ERROR")
                return
            }
            let entries = dateHasData(cellState: selectedCellState.last!)
            newView.entries = entries
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            let formattedString = formatter.string(from: (selectedCellState.last?.date)!)
            newView.dateString = formattedString
            newView.dataSource = self.dataSource
            newView.previousView = self
            newView.cellState = selectedCellState.last
            newView.calendarView = calendarView
            newView.managedObjectContext = managedObjectContext
        } else {
            CalendarError.presentErrorWith(title: ErrorTitle.segueError, message: ErrorMessage.segue, view: self)
            print(ErrorMessage.segue.rawValue)
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        if selectedCell != [] {
            
            resetCalendar()
        }
    }
    
    //FIXME: - TOO LONG
    @IBAction func deleteEntry(_ sender: Any) {
        guard let entries = dataSource.fetchEntries() else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            return
        }
        
        for entry in entries {
            if entry.date == selectedCellState.last?.date {
                managedObjectContext.delete(entry)
                managedObjectContext.saveChanges()
            }
        }
        resetCalendar()
    }
    
    //Calendar Setup
    
    ///Brings view to current day
    func loadTodayView() {
        
        calendarView.scrollToDate(Date(), animateScroll: false)
        
        // This code auto selects the current day
        //let currentDate: [Date] = [Date()]
        //calendarView.selectDates(currentDate)
    }
    @objc func scrollToToday() {
        calendarView.scrollToDate(Date(), animateScroll: true)
    }
    
    ///Sets up calindar spacing and visible dates
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    //FIXME: - TOO LONG
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
    
    //App Delegate Code
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    //Loads all cells
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.dateLabel.text = cellState.text
        colorFor(cell, with: cellState)
        
        return cell
    }
    
    //FIXME: - TOO LONG
    //Runs when cell is selected
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        if matchingDataWith(array: selectedCellState, state: cellState) == true {
            
            return
        }
        if dateHasData(cellState: cellState) == nil {
            selectedCellState = [cellState]
            performSegue(withIdentifier: "detailSegue", sender: nil)
            
        } else if dateHasData(cellState: cellState) != nil {
            displaySelectedCell(cell: cell!)
            selectedCellState.append(cellState)
            selectedCell.append(cell!)
            moreButton.isEnabled = true
            if let entries = dateHasData(cellState: selectedCellState) {
                updateLabels(tips: String("\(Calculate.tips(entries: entries))"), hours: String("\(Calculate.hours(entries: entries))"), hourly: Calculate.hourly(entries: entries))
            } else {
                CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            }
        } else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupCalendarView()
    }
    
    //Calendar Helper functions
    //FIXME: - TOO LONG
    func colorFor(_ cell :JTAppleCell, with cellState: CellState) {
        guard let calCell = appleCellToCalendarCell(cell: cell) else{
            CalendarError.presentErrorWith(title: ErrorTitle.castingError, message: ErrorMessage.casting, view: self)
            return
        }
        
        switch cellState.dateBelongsTo {
        case .thisMonth:
            if dateHasData(cellState: [cellState]) != nil {
                
                calCell.dateLabel.textColor = CalendarColors.green
                
            } else  {
                calCell.dateLabel.textColor = CalendarColors.black
            }
            
        default:
            calCell.dateLabel.textColor = CalendarColors.lightGrey
        }
    }
    
    //helper method that casts Apple cell to Cal Cell
    func appleCellToCalendarCell(cell: JTAppleCell) -> CalendarCell? {
        guard let calCell = cell as? CalendarCell else {
            CalendarError.presentErrorWith(title: ErrorTitle.castingError, message: ErrorMessage.casting, view: self)
            return nil
        }
        return calCell
    }
    //FIXME: - TOO LONG
    func dateHasData(cellState: [CellState]) -> [Entry]? {
        guard let entries = dataSource.fetchEntries() else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            return nil
        }
        var array: [Entry] = []
        
        for entry in entries {
            for cells in cellState {
                if entry.date == cells.date {
                    
                    array.append(entry)
                }
            }
        }
        if array == [] {
            return  nil
        } else {
            return array
        }
    }
    //FIXME: - TOO LONG
    func dateHasData(cellState: CellState) -> [Entry]? {
        guard let entries = dataSource.fetchEntries() else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            return nil
        }
        var array: [Entry] = []
        
        for entry in entries {
            if entry.date == cellState.date {
                
                array.append(entry)
            }
        }
        if array == [] {
            return  nil
        } else {
            return array
        }
    }
    
    func matchingDataWith(array states: [CellState], state: CellState) -> Bool {
        
        for cell in states {
            if cell.date == state.date {
                return true
            }
        }
        return false
    }
    
    func indexForCellAndState(_ state: CellState) -> Int? {
        var index = 0
        for cell in selectedCellState {
            
            if cell.date == state.date {
                return index
            }
            index += 1
        }
        return nil
    }
    
    func displaySelectedCell(cell: JTAppleCell) {
        let calCell = appleCellToCalendarCell(cell: cell)!
        if cell.isSelected {
            //calCell.selectedView.isHidden = false
            calCell.circleImage.isHidden = false
            calCell.dateLabel.textColor = CalendarColors.white
            print("selected")
        } else {
           // calCell.selectedView.isHidden = true
            calCell.circleImage.isHidden = true
            calCell.dateLabel.textColor = CalendarColors.black
        }
    }
    
    func updateLabels(tips: String = "0.00", hours: String = "0", hourly: String = "0.00") {
        let dollarSign = "$"
        hourlyLabel.text = dollarSign + hourly
        tipsLabel.text = dollarSign + tips
        hoursLabel.text = hours
    }
    
    func stringFromNumber(_ number: Double) -> String {
        return String("\(number)")
    }
    
    func resetCalendar() {
        for cell in selectedCell {
            cell.isSelected = false
            displaySelectedCell(cell: cell)
        }
        updateLabels()
        selectedCellState = []
        selectedCell = []
        calendarView.reloadData()
        moreButton.isEnabled = false
    }    
}












/*
 
 For 1.0:
 
 TODAY:
 enter data
 √ delete single item
 √ add multiple items per day
 edit
 
 **Redesign:**
 1. App Icon
 2. New Color Scheme
 3. Fix /redesign buttons and clean up UI
 
 **Bugs/ Maintenance:**
 √ fix select multiple days / random selcections on clear press
 √ make tips text field first responder when detailVC launches
 √ error handling...
 √ Add $ signs to labels
 √ highlight green when new entry is entered
 letters in text fields
 
 **New Functionality:**
 editing
 deleting to same day
 adding to same day
 settings
 
 Update:::
 fix upDate labels so it's always displaying what's actually in selected cells. and create double to text function
 fix toggle on and off selected cell
 batch delete
 Reports page?
 
 
 **Future Features:**
 Color themes
 slide to select days?
 select all days in button
 add item text field in the same VC so no need to detailVC
 
 
 */
