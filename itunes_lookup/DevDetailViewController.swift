//
//  DevDetailViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 10/10/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

class DevDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return SearchResultsStore.sharedInstance().developerResults.count
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

        let controller = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.searchObject = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
        navigationController!.pushViewController(controller, animated: true)
    }
}







