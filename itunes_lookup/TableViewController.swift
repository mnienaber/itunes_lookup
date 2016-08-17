//
//  TableViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/17/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {

    var appDelegate: AppDelegate!


    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.reloadData()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        getSearchItems()
    }

    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)
        getSearchItems()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellReuseIdentifier = "TableViewCell"
        let searchResult = Client.sharedInstance().searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!

        cell.textLabel!.text = searchResult.artistName
        cell.detailTextLabel!.text = searchResult.bundleId
        print(searchResult.bundleId)

        return cell
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Client.sharedInstance().searchResults.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let location = Client.sharedInstance().searchResults[indexPath.row]
        let url = location.bundleId


    }

    func getSearchItems() {

        if Client.sharedInstance().searchResults.isEmpty == true {

            performUIUpdatesOnMain {

                print("problems")

                //self.failAlertGeneral("Yikes", message: "There was a problem retrieving data, please try again later", actionTitle: "OK")
            }
        } else if Client.sharedInstance().searchResults.isEmpty == false {

            performUIUpdatesOnMain {

                for _ in Client.sharedInstance().searchResults {

                    self.tableView.reloadData()
                    print("getStudentList()")
                }
            }
        }
    }



}