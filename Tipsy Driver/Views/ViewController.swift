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
    @IBOutlet weak var tipsTextLabel: UILabel!
    @IBOutlet weak var hoursTextLabel: UILabel!
    @IBOutlet weak var hourlyTextLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    //Variables
    let managedObjectContext = CoreDataStack().managedObjectContext
    lazy var dataSource: DataSource = {
        return DataSource(context: self.managedObjectContext, calendar: self.calendar)
    }()
    
    //MARK: - View Controller
    override func viewWillAppear(_ animated: Bool) {
        isSelectedCellDataHidden(true)
        if calendar != nil {
            calendar.resetCalendar()
        }
        updateLabels()
        setUpCalendarLabels(date: Date())
        moreButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendar.calendarDataSource = dataSource
        calendar.calendarDelegate = calendar
        calendar.view = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapToToday))
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(tap)
        scrollToToday()
    }
    
    //MARK: - UIButtons
    @IBAction func clearButton(_ sender: Any) {
        if calendar.selectedCellStates.count > 0 {
            calendar.resetCalendar()
        }
        moreButton.isEnabled = false
    }

    @IBAction func moreButton(_ sender: Any) {
        if calendar.selectedCellStates.count > 0 {
            performSegue(withIdentifier: SegueIdentifier.moreButtonSegue.rawValue, sender: nil)
        }
    }
    
    @IBAction func deleteEntry(_ sender: Any) {
        guard let entries = dataSource.fetchEntries() else {
            CalendarError.presentErrorWith(title: ErrorTitle.fetchingError, message: ErrorMessage.fetching, view: self)
            return
        }
        let alertController = UIAlertController(title: formatDeleteDate(), message: ErrorMessage.delete.rawValue, preferredStyle: .actionSheet)
        let actionOne = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            for entry in entries {
                if entry.date == self.calendar.selectedCellStates.last?.date {
                    self.managedObjectContext.delete(entry)
                    self.managedObjectContext.saveChanges()
                    self.calendar.resetCalendar()
                }
            }
        })
        let actionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.detailSegue.rawValue {

            guard let newView = segue.destination as? detailViewController else {
                CalendarError.presentErrorWith(title: ErrorTitle.segueError, message: ErrorMessage.segue, view: self)
                return
            }
            newView.managedObjectContext = managedObjectContext
            newView.cellState = calendar.selectedCellStates.last

        } else if segue.identifier == SegueIdentifier.moreButtonSegue.rawValue {

            let destinationNavigationController = segue.destination as! UINavigationController
            guard let newView = destinationNavigationController.topViewController as? moreTableViewController else {
                CalendarError.presentErrorWith(title: ErrorTitle.segueError, message: ErrorMessage.segue, view: self)
                return
            }

            newView.dataSource = self.dataSource
            newView.cellState = calendar.selectedCellStates.last
            newView.managedObjectContext = managedObjectContext
        } else if segue.identifier == SegueIdentifier.settings.rawValue {
            
            //CODE
            
        } else {
            CalendarError.presentErrorWith(title: ErrorTitle.segueError, message: ErrorMessage.segue, view: self)
        }
    }

    
    //MARK: - Calendar

    private func scrollToToday() {
        calendar.scrollToDate(Date(), animateScroll: false)
    }
    
    @objc func tapToToday() {
        calendar.scrollToDate(Date(), animateScroll: true)
    }

    func updateLabels(tips: String = "", hours: String = "", hourly: String = "") {
        hourlyLabel.text = hourly
        tipsLabel.text = tips
        hoursLabel.text = hours
    }
    
    func setUpCalendarLabels(date: Date) {
        monthLabel.text = CalendarFormatter.formatWith(date: date, style: .month)
        yearLabel.text = CalendarFormatter.formatWith(date: date, style: .year)
    }
    
    func isSelectedCellDataHidden (_ bool: Bool) {
        tipsTextLabel.isHidden = bool
        tipsLabel.isHidden = bool
        hoursTextLabel.isHidden = bool
        hoursLabel.isHidden = bool
        hourlyTextLabel.isHidden = bool
        hourlyLabel.isHidden = bool
        clearButton.isHidden = bool
        editButton.isHidden = bool
        deleteButton.isHidden = bool
    }
    
    
    private func formatDeleteDate() -> String {
            let date = CalendarFormatter.formatWith(date: calendar.selectedCellStates.last!.date, style: .display)
        
        
        return date
    }

}
































