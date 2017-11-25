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



class ViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    
    
    let manangedObjectContext = CoreDataStack().managedObjectContext
    var selectedCellState: CellState?

    let formatter = DateFormatter()
    
    lazy var dataSource: DataSource = {
        return DataSource(context: self.manangedObjectContext, formatter: self.formatter, calendar: self.calendarView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.calendarDataSource = dataSource
        setupCalendarView()
        
        todayView(animated: false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.todayView))
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(tap)
        
        print("LOADED!!")
        
        
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let newView = segue.destination as? detailViewController
            
            newView?.managedObjectContext = manangedObjectContext
            if selectedCellState != nil {
                newView?.cellState = selectedCellState!
            } else {
                print("Cell State is nil... I don't know why")
                fatalError()
            }
        } else {
            print("Error preparing segue")
        }
    }


}

























