//
//  Entry+CoreDataClass.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//
//

import Foundation
import CoreData

public class Entry: NSManagedObject {
    @ nonobjc public func fetchRequest() -> NSFetchRequest<Entry> {
        
        return NSFetchRequest<Entry>(entityName: "Entry")
        
    }
    
    func entryFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        return Entry.fetchRequest()
    }
}



