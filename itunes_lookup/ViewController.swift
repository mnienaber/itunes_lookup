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

    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func goButton(sender: AnyObject) {
        
        let query = searchBarOutlet.text
        testApi(query!)
        
    }

    
    func testApi(query: String) {

        Client.sharedInstance().getSearchItems(query) { (searchResultsDict, error) in

            if error != nil {

                performUIUpdatesOnMain {

                    print(error)
                }

            } else {

                performUIUpdatesOnMain {

                    dispatch_async(dispatch_get_main_queue(), {
                        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TableViewControllerForSegue")
                        self.presentViewController(controller, animated: true, completion: nil)
                    })
                }


            }
        }
    }
}

