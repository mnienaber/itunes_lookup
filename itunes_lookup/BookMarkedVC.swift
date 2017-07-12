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

  let delegate = UIApplication.shared.delegate as! AppDelegate
  var segueApp = App()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "App")
    fr.sortDescriptors = [NSSortDescriptor(key: "appName", ascending: true)]
    fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (self.delegate.stack.context), sectionNameKeyPath: nil, cacheName: nil)

    print("sections: \(self.fetchedResultsController?.fetchedObjects?.count)")
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let app = fetchedResultsController?.object(at: indexPath) as! App
    let cell = tableView.dequeueReusableCell(withIdentifier: "App", for: indexPath)

    cell.textLabel?.text = app.appName
    //TODO: insert icon image without crashing
    //cell.imageView?.image = UIImage(data: app.image!)


    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    segueApp = fetchedResultsController?.object(at: indexPath) as! App
    print("didselect_segueApp:  \(segueApp)")

//    performSegue(withIdentifier: "segue", sender: self)

  }

//  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//    if segue.identifier == "segue" {
//      let destVC = segue.destination as! DetailBookMarkedVC
//      destVC.detailApp = segueApp
//      print("destVC.detailApp:  \(destVC.detailApp)")
//
//    }
//  }


  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    if editingStyle == .delete {
      print(fetchedResultsController?.object(at: indexPath))
      self.delegate.stack.context.delete(fetchedResultsController?.object(at: indexPath) as! NSManagedObject)
      self.delegate.stack.save()
      do {
        try self.fetchedResultsController?.performFetch()
      } catch {
        let fetchError = error as NSError
        print("Unable to Perform Fetch Request")
        print("\(fetchError), \(fetchError.localizedDescription)")
      }

      performUIUpdatesOnMain {
        
        print("sections: \(self.fetchedResultsController?.fetchedObjects?.count)")
        tableView.reloadData()
      }
    }
  }
}


