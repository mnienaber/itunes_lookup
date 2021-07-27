//
//  ViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/3/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var blanket: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    blanket.isHidden = true
    activityIndicator.isHidden = true

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    searchBar.delegate = self
    tableView.delegate = self
    self.tableView.reloadData()
    navigationController?.navigationBar.barTintColor = UIColor.white
  }

  func testApi(_ searchText: String) {

    if Reachability.connectedToNetwork() == false {

      alreadyGotAlert(title: "No Connection", message: "You don't seem to be connected to the internet", cancelTitle: "I'll fix it!")
    } else {

      self.blanket.isHidden = false
      self.activityIndicator.isHidden = false
      self.activityIndicator.startAnimating()

      let plusInsert = searchText.components(separatedBy: " ")
      let realSearchText = plusInsert.joined(separator: "+")

      print(realSearchText)

      Client.sharedInstance().getSearchItems(realSearchText) { (searchResultsDict, error) in

        performUIUpdatesOnMain {
          self.blanket.isHidden = true
          self.activityIndicator.isHidden = true
          self.activityIndicator.stopAnimating()
        }

        if error != nil {
          
          self.alreadyGotAlert(title: "Error", message: "Seems to be an error with your query", cancelTitle: "Try Again")
        } else if searchResultsDict?.count == 0 {

          self.alreadyGotAlert(title: "No Results", message: "That Was Unique! Try Another Search Term", cancelTitle: "OK")
        } else {

            if searchResultsDict != nil {

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
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return SearchResultsStore.sharedInstance().searchResults.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 100.0

    let cellIdentifier = "cell"

    let cell:CustomTableCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! CustomTableCell
    let obj = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
    cell.detailLabel?.textAlignment = NSTextAlignment.right
    cell.mainLabel?.textAlignment = NSTextAlignment.left
    cell.mainLabel?.adjustsFontSizeToFitWidth = true
    cell.mainLabel!.text = obj.trackName as? String

    if obj.kind as! String == "software" {

      cell.detailLabel?.text = "app"
    }
    cell.iconImage.image = UIImage(named: "image")

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let controller = storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
    controller.searchObject = SearchResultsStore.sharedInstance().searchResults[(indexPath as NSIndexPath).row]
    navigationController!.pushViewController(controller, animated: true)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    SearchResultsStore.sharedInstance().searchResults = []
    searchBar.resignFirstResponder()

    let searchText = searchBar.text!
    if Reachability.connectedToNetwork() == false {

      performUIUpdatesOnMain {
        self.alreadyGotAlert(title: "No Connection", message: "You don't seem to be connected to the internet", cancelTitle: "I'll fix it!")
      }
      print("no connection")
    } else {
    testApi(searchText)
    }
    self.tableView.reloadData()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    searchBar.resignFirstResponder()
    searchBar.text = ""
  }
}

extension UIViewController {

  func alreadyGotAlert(title: String, message: String, cancelTitle: String) {

    let markAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

    let cancelTitle = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: {

      (cancelTitle: UIAlertAction!) in print("Got it")
    })
    markAlertGeneral.addAction(cancelTitle)
    self.present(markAlertGeneral, animated: true, completion: nil)
  }
}


