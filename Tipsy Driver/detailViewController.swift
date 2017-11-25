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
    
    
    
    var managedObjectContext = CoreDataStack().managedObjectContext
    var calendarView: JTAppleCalendarView!
    var cellState: CellState!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let hourly = hoursTextField.text, let tips = tipsTextField.text else {
            print("Error in creating hourly and tips")
            return
        }
        
        guard let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: managedObjectContext) as? Entry else {
            print("ERROR: You errored Moron. The entry didn't work.")
            return
        }

        entry.date = cellState.date
        entry.hours = Double(hourly)!
        entry.tips = Double(tips)!
        
        print("Date: \(String(describing: entry.date)), Hours: \(entry.hours), Tips: \(entry.tips). Here We GO!!")
        
        managedObjectContext.saveChanges()
        dismiss(animated: true, completion: nil)
    }
}





































