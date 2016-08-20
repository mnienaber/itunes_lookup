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

    var searchActive: Bool = false
    var data = Client.sharedInstance().searchResults
    var filtered = Client.sharedInstance().searchResults

    override func viewDidLoad() {
        super.viewDidLoad()
        //searchBar.showsScopeBar = true
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        searchBar.delegate = self
        tableView.delegate = self
        self.tableView.reloadData()
    }

    func searchBar(searchBar: UISearchBar, textDidChange query: String) {


        print(query)


        performUIUpdatesOnMain {

            self.testApi(query)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as UITableViewCell
        let obj = Client.sharedInstance().searchResults[indexPath.row]
        cell.textLabel!.text = obj.artistName as? String
        cell.imageView!.image = UIImage(named: "iconplaceholder")
        performUIUpdatesOnMain {

            cell.imageView!.downloadImageFrom(link: obj.artworkUrl60 as! String, contentMode: UIViewContentMode.ScaleAspectFit)
            self.tableView.reloadData()
        }
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Client.sharedInstance().searchResults.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let location = Client.sharedInstance().searchResults[indexPath.row]
        //let url = location.bundleId
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;e
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    func testApi(query: String) {

        Client.sharedInstance().getSearchItems(query) { (searchResultsDict, error) in

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
}



