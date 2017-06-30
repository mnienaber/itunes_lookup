//
//  ViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/3/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!

  var appDelegate: AppDelegate!
  var searchActive: Bool = false
  var alertController: UIAlertController?

  override func viewDidLoad() {
    super.viewDidLoad()

    searchBar.delegate = self
    searchBar.showsScopeBar = true
    tableView.delegate = self
    tableView.dataSource = self
    searchBar.isFirstResponder
    appDelegate = UIApplication.shared.delegate as! AppDelegate
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    searchBar.delegate = self
    tableView.delegate = self
    self.tableView.reloadData()
    navigationController?.navigationBar.barTintColor = UIColor.white
//    titleTextAttributes = [ NSFontAttributeName: UIFont(name: "SF-UI-Text-Bold", size: 34)! ]
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
    let cellIdentifier = "cell"

    let cell:CustomTableCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! CustomTableCell
    let obj = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
    cell.detailLabel?.textAlignment = NSTextAlignment.right
    cell.mainLabel?.textAlignment = NSTextAlignment.left
    cell.mainLabel!.text = obj.trackName as? String
    if obj.kind as! String == "software" {

      cell.detailLabel?.text = "app"
    }
    cell.iconImage.image = UIImage(named: "image")

    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
      return 1
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let controller = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    controller.searchObject = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
    print(controller.searchObject)
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

extension ViewController {

  func failAlertGeneral(title: String, message: String, actionTitle: String) {

      let failAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
      failAlertGeneral.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
      self.present(failAlertGeneral, animated: true, completion: nil)
  }
}



