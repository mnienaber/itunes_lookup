//
//  ViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/3/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var appDelegate: AppDelegate!
    var searchActive: Bool = false
    var data = Client.sharedInstance().searchResults
    var filtered = Client.sharedInstance().searchResults

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.showsScopeBar = true
        tableView.delegate = self
        tableView.dataSource = self
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }

    override func viewWillAppear(animated: Bool) {
        searchBar.delegate = self
        tableView.delegate = self
        self.tableView.reloadData()
    }

    func testApi(searchText: String) {

        Client.sharedInstance().getSearchItems(searchText) { (searchResultsDict, error) in

            if error != nil {

                performUIUpdatesOnMain {

                    print(error)
                }

            } else {

                performUIUpdatesOnMain {

                    for _ in Client.sharedInstance().searchResults {

                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.reloadData()
                        })
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print(Client.sharedInstance().searchResults.count)

        return Client.sharedInstance().searchResults.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let obj = Client.sharedInstance().searchResults[indexPath.row]
        cell.textLabel!.text = obj.artistName as? String
        return cell

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let controller = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")
        //controller.se = Client.sharedInstance().searchResults[indexPath.row]
        navigationController!.pushViewController(controller, animated: true)
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
        let searchText = searchBar.text!
        testApi(searchText)

    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
        searchBar.text = ""
    }

}




