//
//  SearchResultsObject.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/17/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

var searchResultsObjects = [SearchResultsDict]()

struct SearchResultsDict {
    
    let artistName: String
    let bundleId: String
    let appId: String
    let releaseDate: String
    let country: String
    let currency: String
    let languageCodesISO2A: String
    let formattedPrice: String

    init?(dictionary: [String: AnyObject]) {

        artistName = dictionary[Client.Constants.SearchResults.ArtistName] as! String
        bundleId = dictionary[Client.Constants.SearchResults.BundleId] as! String
        appId = dictionary[Client.Constants.SearchResults.TrackId] as! String
        releaseDate = dictionary[Client.Constants.SearchResults.ReleaseDate] as! String
        currency = dictionary[Client.Constants.SearchResults.currency] as! String
        languageCodesISO2A = dictionary[Client.Constants.SearchResults.languageCodesISO2A] as! String
        formattedPrice = dictionary[Client.Constants.SearchResults.FormattedPrice] as! String
        country = dictionary[Client.Constants.SearchResults.country] as! String

    }

    static func SLOFromResults(results: [[String:AnyObject]]) -> [SearchResultsDict] {

        for result in results {

            if let searchObjects = SearchResultsDict(dictionary: result) {

                searchResultsObjects.append(searchObjects)
            }
        }
        return searchResultsObjects
    }


}