// font: 16pt
//  ViewController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/21/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.

import UIKit
import JTAppleCalendar
import CoreData
import Foundation

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var calendar: MyCalendar!
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
        return DataSource(context: self.managedObjectContext, calendar: self.calendar)
    }()
    
    //MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.calendarDataSource = dataSource
        updateLabels()
        moreButton.isEnabled = false
        calendar.SetupCellSpacing()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.scrollToToday))
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(tap)
        loadTodayView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.detailSegue.rawValue {
            
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
            newView.calendarView = calendar
            newView.viewController = self
        } else if segue.identifier == SegueIdentifier.moreButtonSegue.rawValue {
            
            let destinationNavigationController = segue.destination as! UINavigationController
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
            newView.calendarView = calendar
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
    
    @IBAction func deleteEntry(_ sender: Any) {
        guard let entries = dataSource.fetchEntries() else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            return
        }
        
        let alertController = UIAlertController(title: ErrorTitle.delete.rawValue, message: ErrorTitle.delete.rawValue, preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "Delete", style: .default, handler: { _ in
            for entry in entries {
                if entry.date == self.selectedCellState.last?.date {
                    self.managedObjectContext.delete(entry)
                    self.managedObjectContext.saveChanges()
                    self.resetCalendar()
                }
            }
        })
        let actionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Calendar
    
    ///Brings view to current day
    func loadTodayView() {
        calendar.scrollToDate(Date(), animateScroll: false)
    }
    
    @objc func scrollToToday() {
        calendar.scrollToDate(Date(), animateScroll: true)
    }

    func updateLabels(tips: String = "", hours: String = "", hourly: String = "") {
        hourlyLabel.text = hourly
        tipsLabel.text = tips
        hoursLabel.text = hours
    }
    
    func resetCalendar() {
        for cell in selectedCell {
            cell.isSelected = false
        }
        updateLabels()
        selectedCellState = []
        selectedCell = []
        calendar.deselectAllDates()
        calendar.reloadData()
        
    }
    
    //MARK: - App Delegate

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        // to see if the cell has already been selected
        if matchingDataWith(array: selectedCellState, state: cellState) == true {
            return
        }
        if dateHasData(cellState: cellState) == nil {
            selectedCellState = [cellState]
            performSegue(withIdentifier: "detailSegue", sender: nil)
            
        } else if dateHasData(cellState: cellState) != nil {
            selectedCellState.append(cellState)
            selectedCell.append(cell!)
            moreButton.isEnabled = true
            if let entries = dateHasData(cellState: selectedCellState) {
                updateLabels(tips: Calculate.tips(entries: entries), hours: Calculate.hours(entries: entries), hourly: Calculate.hourly(entries: entries))
            } else {
                CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            }
        } else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
        }
    }
    
    //MARK: - Helper Methods
    
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
}


























