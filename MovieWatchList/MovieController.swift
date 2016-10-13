//
//  MovieController.swift
//  MovieWatchList
//
//  Created by Patrick Ridd on 10/13/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import Foundation
import CoreData

let addedMovie = "addedMovie"

class MovieController {
    
    static let sharedController = MovieController()
    let moc = CoreDataStack.context
    var movies: [Movie] = [] {
        didSet {
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: addedMovie), object: self)
        }
    }
    
    
    init() {
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            let movies = try moc.fetch(request)
             self.movies = movies
        } catch let error as NSError{
            print("Error fetching Movies. Error: \(error.localizedDescription)")
        }
        
    }
    
    
    func addMovie(title: String) {
        let movie = Movie(title: title)
        movies.append(movie)
        saveToPersistentStorage()
    }
    
    
    func deleteMovie(movie: Movie) {
        guard let index = movies.index(of: movie) else {
            return
        }
        movies.remove(at: index)
        movie.managedObjectContext?.delete(movie)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        do {
            try moc.save()
        } catch let error {
            NSLog("Error saving to context. \(error)")
        }
        
    }

}
