//
//  WatchListTableViewController.swift
//  MovieWatchList
//
//  Created by Patrick Ridd on 10/13/16.
//  Copyright © 2016 PatrickRidd. All rights reserved.
//

import UIKit

class WatchListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableView), name: NSNotification.Name(rawValue: addedMovie), object: nil)
        // Sync movies
    }
    
    
    @IBAction func addMovie(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Movie to WatchList", message: nil, preferredStyle: .alert)
        var titleTextField: UITextField?
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Enter title of movie"
            titleTextField = textfield
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let title = titleTextField?.text, title.characters.count > 0 else {
                return
            }
            MovieController.sharedController.addMovie(title: title)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addButton)
        self.present(alert, animated: true, completion: nil)
    
        
    }
    func reloadTableView() {
        tableView.reloadData()
    }
    
       // MARK: - Table view data source

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieController.sharedController.movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let movie = MovieController.sharedController.movies[indexPath.row]
        cell.textLabel?.text = movie.title
        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = MovieController.sharedController.movies[(indexPath as NSIndexPath).row]
            
            MovieController.sharedController.deleteMovie(movie: movie)
            
        }
        
    }
    
    
}
