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
    @IBOutlet weak var blueTopView: UIView!
    
    var managedObjectContext = CoreDataStack().managedObjectContext
    var entryBeingEdited: Entry?
    var cellState: CellState!
    var calendar: MyCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = CalendarFormatter.formatWith(date: cellState.date, style: .display)
        hoursTextField.becomeFirstResponder()
        if Helper.deviceSize() != .normalPhone {
            titleLabel.font = titleLabel.font.withSize(24)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        Helper.ChangeTheme(controller: self, topView: blueTopView)
        if entryBeingEdited != nil {
            setUpDisplayForEditingCell()
        }
    }

    @IBAction func cancel(_ sender: Any) {
        self.view.endEditing(true)
        if entryBeingEdited == nil {
            self.dismiss(animated: true, completion: nil)
            entryBeingEdited = nil
        } else {
            navigationController?.popViewController(animated: true)
            entryBeingEdited = nil
        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        guard let hourly = hoursTextField.text, let tips = tipsTextField.text else {
            CalendarError.presentErrorWith(title: ErrorTitle.savingError, message: ErrorMessage.saving, view: self)
            return
        }
        if CalendarError.isValid(text: hourly) == false || CalendarError.isValid(text: tips) == false {
            CalendarError.presentErrorWith(title: ErrorTitle.invalidText, message: ErrorMessage.invalidText, view: self)
            return
        }
        if entryBeingEdited != nil {
            saveEditedEntryChanges()
            entryBeingEdited = nil
            navigationController?.popViewController(animated: true)
        } else {
            guard let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: managedObjectContext) as? Entry else {
                CalendarError.presentErrorWith(title: ErrorTitle.savingError, message: ErrorMessage.saving, view: self)
                return
            }
        
            self.view.endEditing(true)

            entry.date = cellState.date
            entry.hours = Double(hourly)!
            entry.tips = Double(tips)!
            
            managedObjectContext.saveChanges()
            entryBeingEdited = nil
            calendar.resetCalendar()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func setUpDisplayForEditingCell() {
        hoursTextField.text = String("\(entryBeingEdited!.hours)")
        tipsTextField.text = String("\(entryBeingEdited!.tips)")
    }

    
    func saveEditedEntryChanges() {
        let object = Helper.convertEntryToObject(entry: entryBeingEdited!)
        object.setValue(Helper.convertStringToNSNumber(numberAsString: tipsTextField.text!), forKey: "tips")
        object.setValue(Helper.convertStringToNSNumber(numberAsString: hoursTextField.text!), forKey: "hours")
        managedObjectContext.saveChanges()
    }

}










































