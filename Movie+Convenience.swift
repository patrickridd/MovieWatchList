//
//  Movie+Convenience.swift
//  MovieWatchList
//
//  Created by Patrick Ridd on 10/13/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import Foundation
import CoreData

extension Movie {
    
    convenience init(title: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.title = title
    }
    
    
}
