//
//  CoreDataStack.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    
    
    // this is all the code needed to create the core data stack
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext
        
    }()
    
    
    private lazy var persistentContainer: NSPersistentContainer = {
        // FIXME: - Fix the container
        let container = NSPersistentContainer(name: "Entry")
        container.loadPersistentStores() { storeDiscription, error in
            if let error = error as NSError? {
                fatalError("Unresolved Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}



extension NSManagedObjectContext {
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

