//
//  BookMarkedVC.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 6/28/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class BookMarkedVC: CoreDataTableViewController {

  @IBOutlet weak var tableView: UITableView!
  //let delegate = UIApplication.shared.delegate as! AppDelegate

  override func viewDidLoad() {
    super.viewDidLoad()

//    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "App")
//    fr.predicate = NSPredicate(format: "app = %@")
//    fr.sortDescriptors = [NSSortDescriptor(key: "appName", ascending: true)]
//    fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (self.delegate.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

  }
//
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    // Get the note
//    let app = fetchedResultsController?.object(at: indexPath) as! App
//
//    // Get the cell
//    let cell = tableView.dequeueReusableCell(withIdentifier: "App", for: indexPath)
//
//    // Sync note -> cell
//    cell.textLabel?.text = app.appName
//    //cell.imageView?.image = app.image
//
//    // Return the cell
//    return cell
//  }

}
