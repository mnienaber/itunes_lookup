//
//  Convenience.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/17/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

extension Client {

    func getSearchItems(_ query: String, completionHandlerForSearchResults: @escaping (_ result: [SearchResultsDict]?, _ error: NSError?) -> Void) {

        let url = Client.Constants.Scheme.SearchMethod + query + Client.Constants.Scheme.limitAndApp   

        taskForGETMethod(url, query: query) { results, error in

            if let error = error {

                print(error)
            } else {

                if let results = results?["results"] as? [[String:AnyObject]] {

                    SearchResultsStore.sharedInstance().searchResults = []

                    let searchItems = SearchResultsDict.SLOFromResults(results)
                    SearchResultsStore.sharedInstance().searchResults = searchItems

                    completionHandlerForSearchResults(searchItems, nil)
                } else {

                    completionHandlerForSearchResults(nil, error)
                }
            }
        }
    }
}
