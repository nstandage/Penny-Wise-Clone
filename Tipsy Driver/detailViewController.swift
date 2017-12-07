//
//  detailViewController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData

class detailViewController: UIViewController {

    @IBOutlet weak var tipsTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //FIXME: - TOO LONG, Can I get rid of some of these variables?
    var managedObjectContext = CoreDataStack().managedObjectContext
    var calendarView: JTAppleCalendarView!
    var cellState: CellState!
    var dateString: String!
    var viewController: ViewController!
    var tableView: moreTableViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = dateString
        tipsTextField.becomeFirstResponder()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancel(_ sender: Any) {
        self.view.endEditing(true)
        viewController.resetCalendar()
        dismiss(animated: true, completion: nil)
    }
    
    //FIXME: - TOO LONG
    @IBAction func save(_ sender: Any) {
        guard let hourly = hoursTextField.text, let tips = tipsTextField.text else {
            CalendarError.presentErrorWith(title: ErrorTitle.savingError, message: ErrorMessage.saving, view: self)
            return
        }
        
        if CalendarError.isValid(text: hourly) == false || CalendarError.isValid(text: tips) == false {
            CalendarError.presentErrorWith(title: ErrorTitle.invalidText, message: ErrorMessage.invalidText, view: self)
            return
        }
        
        
            guard let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: managedObjectContext) as? Entry else {
                CalendarError.presentErrorWith(title: ErrorTitle.savingError, message: ErrorMessage.saving, view: self)
                return
            }
        
            self.view.endEditing(true)
            entry.date = cellState.date
            entry.hours = Double(hourly)!
            entry.tips = Double(tips)!
            
            managedObjectContext.saveChanges()
            if tableView != nil {
                tableView?.entries.append(entry)
                print("Party")
                tableView?.refreshTable()
            } else {
                viewController.resetCalendar()
            }

        dismiss(animated: true, completion: nil)
    }

}










































