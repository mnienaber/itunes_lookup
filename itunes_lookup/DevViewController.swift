//
//  DevDetailViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 10/10/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import UIKit

class DevViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        self.tableView.reloadData()
    }

    func testApi(_ searchText: String) {

        let plusInsert = searchText.components(separatedBy: " ")
        let realSearchText = plusInsert.joined(separator: "+")

        print(realSearchText)

        Client.sharedInstance().getSearchItems(realSearchText) { (searchResultsDict, error) in

            if error != nil {

                self.failAlertGeneral(title: "Error", message: "Seems to be an error with your query", actionTitle: "Try Again")
            } else if searchResultsDict?.count == 0 {

                self.failAlertGeneral(title: "No Results", message: "That Was Unique! Try Another Search Term", actionTitle: "OK")
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

        return SearchResultsStore.sharedInstance().searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let obj = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = obj.trackName as? String

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let controller = storyboard!.instantiateViewController(withIdentifier: "DevDetailViewController") as! DetailViewController
        controller.searchObject = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(controller, animated: true)
    }
}

extension DevViewController {

    func failAlertGeneral(title: String, message: String, actionTitle: String) {

        let failAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        failAlertGeneral.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(failAlertGeneral, animated: true, completion: nil)
    }
}

