//
//  DateSource.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/23/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit
import CoreData
import JTAppleCalendar
import Foundation

class DataSource: NSObject, JTAppleCalendarViewDataSource {

    private let context: NSManagedObjectContext
    private let calendar: JTAppleCalendarView
    
    init(context: NSManagedObjectContext, calendar: JTAppleCalendarView) {
        self.context = context
        self.calendar = calendar
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        return ConfigurationParameters.init(startDate: CalendarFormatter.startDate(), endDate: CalendarFormatter.endDate())
    }
    
    // Fetched Stuff
    lazy var fetchedResultsController: CalendarFetchedResultsController = {
        return CalendarFetchedResultsController(managedObjectContext: self.context, calendar: self.calendar)
    }()
    
    func object(at indexPath: IndexPath) -> Entry {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func fetchEntries() -> [Entry]? {
        let fetch = NSFetchRequest<Entry>(entityName: "Entry")
        
        do {
            let fetchedEntries = try context.fetch(fetch as! NSFetchRequest<NSFetchRequestResult>) as! [Entry]
            
            return fetchedEntries
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func shoveIt() -> String {
        return "shoveIt"
    }
}
























