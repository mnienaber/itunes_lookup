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

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.showsScopeBar = true
        tableView.delegate = self
        tableView.dataSource = self
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }

    override func viewWillAppear(_ animated: Bool) {
        searchBar.delegate = self
        tableView.delegate = self
        self.tableView.reloadData()
    }

    func testApi(_ searchText: String) {

        Client.sharedInstance().getSearchItems(searchText) { (searchResultsDict, error) in

            if error != nil {

                performUIUpdatesOnMain {

                    print(error)
                }

            } else {

                if let searchResultsDict = searchResultsDict {

                    performUIUpdatesOnMain {

                        for _ in SearchResultsStore.sharedInstance().searchResults {

                            DispatchQueue.main.async(execute: { () -> Void in
                                self.tableView.reloadData()
                            })

                        }

                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print(SearchResultsStore.sharedInstance().searchResults.count)

        return SearchResultsStore.sharedInstance().searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let obj = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = obj.bundleId as? String
        return cell

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let controller = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.searchObject = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(controller, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        SearchResultsStore.sharedInstance().searchResults = []
        searchBar.resignFirstResponder()

        let searchText = searchBar.text!
        testApi(searchText)
        self.tableView.reloadData()

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
        searchBar.text = ""
    }

}




