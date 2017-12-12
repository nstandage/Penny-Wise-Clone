//
//  moreTableView.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/29/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData

class moreTableViewController: UITableViewController {


    var dateString: String! = nil
    var entries: [Entry]! = nil
    var dataSource: DataSource! = nil
    var previousView: ViewController! = nil
    var cellState: CellState! = nil
    var calendarView: JTAppleCalendarView! = nil
    var managedObjectContext: NSManagedObjectContext! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func refreshTable() {
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("customCell", owner: self, options: nil)?.first as! customCell
        let currentEntry = entries[indexPath.row]
        
        cell.hourlyLabel.text = Calculate.hourly(entries: [currentEntry])
        cell.hoursLabel.text = String(Calculate.hours(entries: [currentEntry]))
        cell.tipsLabel.text = String(Calculate.tips(entries: [currentEntry]))
        
        return cell
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        previousView.resetCalendar()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entries[indexPath.row]
            entries.remove(at: indexPath.row)
            managedObjectContext.delete(entry)
            managedObjectContext.saveChanges()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.addItem.rawValue {

            guard let newView = segue.destination as? detailViewController else {
                  CalendarError.presentErrorWith(title: .segueError, message: .segue, view: self)
                return
            }
            
            
            newView.calendarView = self.calendarView
            newView.managedObjectContext = self.managedObjectContext
            newView.cellState = self.cellState
            newView.dateString = self.dateString
            newView.tableView = self
            
        }
    }
    
    /*
     
     let destinationNavigationController = segue.destination as! UINavigationController
     guard let newView = destinationNavigationController.topViewController as? moreTableViewController else {
     print("ERROR")
     return
     }
     
    var managedObjectContext = CoreDataStack().managedObjectContext
    var calendarView: JTAppleCalendarView!
    var cellState: CellState!
    var dateString: String!
    var viewController: ViewController!
    var tableView: moreTableViewController?
    
     
     
     
    */
}






























