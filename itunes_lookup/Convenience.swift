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

    func getSearchItems(query: String, completionHandlerForSearchResults: (result: [SearchResultsDict]?, error: NSError?) -> Void) {

        let url = Client.Constants.Scheme.SearchMethod + query + Client.Constants.Scheme.limitAndApp   

        taskForGETMethod(url, query: query) { results, error in

            if let error = error {

                print(error)
            } else {

                if let results = results["results"] as? [[String:AnyObject]] {

                    let searchItems = SearchResultsDict.SLOFromResults(results)
                    Client.sharedInstance().searchResults = searchItems

                    completionHandlerForSearchResults(result: searchItems, error: nil)
                } else {

                    completionHandlerForSearchResults(result: nil, error: error)
                }
            }
        }
    }

    


//    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
//
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(url) {
//            (data, response, error) in
//            completion(data: data, response: response, error: error)
//            }
//            task.resume()
//    }
//
//    func downloadImage(url: NSURL) -> UIImage {
//        print("Download Started")
//        getDataFromUrl(url) { (data, response, error)  in
//            guard let data = data where error == nil else { return }
//
//            performUIUpdatesOnMain {
//
//                self.imageView.image = UIImage(data: data)
//            }
//
//            }
//        }
//    }
}
