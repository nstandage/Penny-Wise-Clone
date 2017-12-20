//
//  CalendarFetchedResultsController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/24/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit
import CoreData
import JTAppleCalendar

class CalendarFetchedResultsController: NSFetchedResultsController<Entry>, NSFetchedResultsControllerDelegate {
    
    private let calendar: JTAppleCalendarView
    
    init(managedObjectContext: NSManagedObjectContext, calendar: JTAppleCalendarView) {
        self.calendar = calendar

        
        super.init(fetchRequest: Entry.fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        
        tryFetch()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch {
            // Fix this
        }
    }

    
    
}


































