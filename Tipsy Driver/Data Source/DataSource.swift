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

    func doesCellHaveData(cellState: CellState) -> Bool {
        guard let entries = self.fetchEntries() else {
            print("Couldn't fetch entries")
            fatalError()
        }
        
        for entry in entries {
            if Helper.removeTimeStamp(fromDate: entry.date!) == Helper.removeTimeStamp(fromDate: cellState.date) {
                return true
            }
        }
        return false
    }

    func entriesWith(date: Date) -> [Entry]? {
        var entriesWithMatchingDate: [Entry] = []
        if let entries = fetchEntries() {
            
            for entry in entries {
                if entry.date == date {
                    entriesWithMatchingDate.append(entry)
                }
            }
        }
    
        if entriesWithMatchingDate.count == 0 {
            return nil
        } else {
            return entriesWithMatchingDate
        }
    }
    
    func doesCellStateMatchArray(cellState: CellState, arrayOfStates array:[CellState]) -> Bool {
        
        for state in array {
            if cellState.date == state.date {
                return true
            }
        }

        return false
    }
    
    func getEntriesMatching(cellStates: [CellState]) -> [Entry] {
        var matchingEntries: [Entry] = []
        let entries = fetchEntries()
        for state in cellStates {
            for entry in entries! {
                if Helper.removeTimeStamp(fromDate: state.date) == Helper.removeTimeStamp(fromDate: entry.date!) {
                //if state.date == entry.date {
                    matchingEntries.append(entry)
                }
            }
        }
        return matchingEntries
    }
    
}
























