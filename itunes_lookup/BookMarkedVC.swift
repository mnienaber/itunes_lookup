//
//  BookMarkedVC.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 6/28/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit


class BookMarkedVC: CoreDataTableViewController {


  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    // Get the note
    let app = fetchedResultsController?.object(at: indexPath) as! App

    // Get the cell
    let cell = tableView.dequeueReusableCell(withIdentifier: "App", for: indexPath)

    // Sync note -> cell
    cell.textLabel?.text = app.appName
    //cell.imageView?.image = app.image

    // Return the cell
    return cell
  }

}
