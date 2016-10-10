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

        if Validation.isStringNumerical(string: query) == true {

            let url = Client.Constants.Scheme.LookUpMethod + query

            taskForGETMethod(urlString: url, query: query) { results, error in

                if let error = error {

                    completionHandlerForSearchResults(nil, error)
                } else {

                    if let results = results?["results"] as? [[String:AnyObject]] {

                        //SearchResultsStore.sharedInstance().sharingObject = results

                        let searchItems = SearchResultsDict.SLOFromResults(results: results)

                        completionHandlerForSearchResults(searchItems, nil)
                    } else {
                        
                        completionHandlerForSearchResults(nil, error)
                    }
                }
            }
        } else {

            let url = Client.Constants.Scheme.SearchMethod + query + Client.Constants.Scheme.limitAndApp

            taskForGETMethod(urlString: url, query: query) { results, error in

                if let error = error {

                    completionHandlerForSearchResults(nil, error)
                } else {

                    if let results = results?["results"] as? [[String:AnyObject]] {

                        let searchItems = SearchResultsDict.SLOFromResults(results: results)

                        completionHandlerForSearchResults(searchItems, nil)
                    } else {
                        
                        completionHandlerForSearchResults(nil, error)
                    }
                }
            }
        }
    }
}
