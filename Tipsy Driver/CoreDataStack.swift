//
//  CoreDataStack.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {



    // this is all the code needed to create the core data stack

    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext

    }()


    private lazy var persistentContainer: NSPersistentContainer = {

        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        return container
    }()
    

}



extension NSManagedObjectContext {
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError("NSManagedOjectContext failed to save.")
            }
        }
    }
}

