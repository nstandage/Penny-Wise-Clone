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
    
    
    //Variables
    let managedObjectContext = CoreDataStack().managedObjectContext
    var selectedCellState: CellState?
    let formatter = DateFormatter()
    
    lazy var dataSource: DataSource = {
        return DataSource(context: self.managedObjectContext, formatter: self.formatter, calendar: self.calendarView)
    }()
    
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.calendarDataSource = dataSource
        setupCalendarView()
            tipsLabel.text = ""
            hoursLabel.text = ""
            hourlyLabel.text = ""
        
        todayView(animated: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.todayView))
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(tap)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            let newView = segue.destination as? detailViewController
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            let formattedString = formatter.string(from: (selectedCellState?.date)!)
            newView?.managedObjectContext = managedObjectContext
            if selectedCellState != nil {
                newView?.cellState = selectedCellState!
                newView?.dateString = formattedString
            } else {
                print("Cell State is nil... I don't know why")
                fatalError()
            }
        } else {
            print("Error preparing segue")
        }
    }
    
    
    //Calendar Setup
    
    ///Brings view to current day
    @objc func todayView(animated: Bool = true) {
        
        calendarView.scrollToDate(Date(), animateScroll: animated)
        
        // This code auto selects the current day
        //let currentDate: [Date] = [Date()]
        //calendarView.selectDates(currentDate)
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

    //App Delegate Code
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    //Loads all cells
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        cell.dateLabel.text = cellState.text

       //-> handleCellSelected(view: cell, cellState: cellState)
        colorFor(cell, with: cellState)

        return cell
    }
    
    //Runs when cell is selected
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectedCellState = cellState
        
        if let entry = dateHasData(cellState: cellState) {
            hoursLabel.text = "\(Calculate.hours(entries: entry))"
            tipsLabel.text = "\(Calculate.tips(entries: entry))"
            hourlyLabel.text = Calculate.hourly(entries: entry)
        } else {
          performSegue(withIdentifier: "detailSegue", sender: nil)
        }
        
        
        
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {

    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupCalendarView()
    }
    
    
    
//Calendar Helper functions
    
    func colorFor(_ cell :JTAppleCell, with cellState: CellState) {
        guard let calCell = appleCellToCalendarCell(cell: cell) else{
            fatalError("Couldn't Cast Cell...")
        }

        switch cellState.dateBelongsTo {
        case .thisMonth:
            if dateHasData(cellState: cellState) != nil {
                calCell.dateLabel.textColor = CalendarColors.green
            } else {
                calCell.dateLabel.textColor = CalendarColors.black
            }

        default:
            calCell.dateLabel.textColor = CalendarColors.darkGrey
        }
    }
    
    //helper method that casts Apple cell to Cal Cell
    func appleCellToCalendarCell(cell: JTAppleCell) -> CalendarCell? {
        guard let calCell = cell as? CalendarCell else {
        print("Sorry Charlie, didn't work")
        return nil
        }
    
    return calCell
    }
    
    
    func dateHasData(cellState: CellState) -> [Entry]? {
        guard let entries = dataSource.fetchEntries() else {
            print("Error Getting entries out....")
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
    
}






















