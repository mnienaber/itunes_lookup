//
//  ViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/3/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {

    var searchResultsDict = [SearchResultsDict]()

    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var searchActive: Bool = false
    var data = [String: AnyObject]()
    var filtered = [SearchResultsDict]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarOutlet.showsScopeBar = true
        searchBarOutlet.delegate = self
        tableView.delegate = self
        self.tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {

        self.tableView.reloadData()
    }


//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        searchActive = true;
//    }
//
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        searchActive = false;
//    }
//
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchActive = false;
//    }
//
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchActive = false;
//    }

    func searchBar(searchBar: UISearchBar, textDidChange query: String) {


        print(query)


        performUIUpdatesOnMain {

            self.testApi(query)
            self.tableView.reloadData()
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellReuseIdentifier = "TableViewCell"
        let searchResult = Client.sharedInstance().searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!

        cell.textLabel!.text = searchResult.artistName
        cell.detailTextLabel!.text = searchResult.bundleId
        print(searchResult.bundleId)

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Client.sharedInstance().searchResults.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let location = Client.sharedInstance().searchResults[indexPath.row]
        let url = location.bundleId
        
        
    }



    func testApi(query: String) {

        Client.sharedInstance().getSearchItems(query) { (searchResultsDict, error) in

            if error != nil {

                performUIUpdatesOnMain {

                    print(error)
                }

            } else {

                performUIUpdatesOnMain {


                    self.tableView.reloadData()
                }
            }
        }
}
}



