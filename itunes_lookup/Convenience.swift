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

    func getSearchItems(query: String, completionHandlerForStudentLocations: (result: [SearchResultsDict]?, error: NSError?) -> Void) {

        let url = Client.Constants.Scheme.SearchMethod + query + Client.Constants.Scheme.limitAndApp   

        taskForGETMethod(url, query: query) { results, error in
            if let error = error {

                print(error)
            } else {

                if let results = results[Client.Constants.SearchResults.ArtistName] as? [[String:AnyObject]] {

                    let searchItems = SearchResultsDict.SLOFromResults(results)
                    Client.sharedInstance().searchResults = searchItems
                    print(searchItems)

                    completionHandlerForStudentLocations(result: searchItems, error: nil)
                } else {

                    completionHandlerForStudentLocations(result: nil, error: error)
                }
            }
        }
    }
}
