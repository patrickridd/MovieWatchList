//
//  CoreDataStack.swift
//  MovieWatchList
//
//  Created by Patrick Ridd on 10/13/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieWatchList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
}
