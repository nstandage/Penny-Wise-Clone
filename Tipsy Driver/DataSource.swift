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
    
    private let formatter: DateFormatter
    private let context: NSManagedObjectContext
    private let calendar: JTAppleCalendarView
    
    init(context: NSManagedObjectContext, formatter: DateFormatter, calendar: JTAppleCalendarView) {
        self.context = context
        self.formatter = formatter
        self.calendar = calendar
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        guard let startDate = formatter.date(from: "2016 01 01"), let endDate = formatter.date(from: "2019 12 31") else {
            fatalError("Couldn't create dates")
        }
        
        let parameters = ConfigurationParameters.init(startDate: startDate, endDate: endDate)
        return parameters
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
}
























