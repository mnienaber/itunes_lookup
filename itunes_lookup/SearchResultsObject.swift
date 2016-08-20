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
var searchResultsObjDictionary = [String: AnyObject]()

struct SearchResultsDict {

    let artistName: AnyObject
    let bundleId: AnyObject
    let appId: AnyObject
    let releaseDate: AnyObject
    let currency: AnyObject
    let languageCodesISO2A: [AnyObject]
    let formattedPrice: AnyObject

    init?(dictionary: [String: AnyObject]) {

        artistName = (dictionary[Client.Constants.SearchResults.ArtistName] as AnyObject!)!
        bundleId = (dictionary[Client.Constants.SearchResults.BundleId] as AnyObject!)!
        appId = (dictionary[Client.Constants.SearchResults.TrackId] as AnyObject!)!
        releaseDate = (dictionary[Client.Constants.SearchResults.ReleaseDate] as AnyObject!)!
        currency = (dictionary[Client.Constants.SearchResults.currency] as AnyObject!)!
        languageCodesISO2A = (dictionary[Client.Constants.SearchResults.languageCodesISO2A] as! [AnyObject]!)!
        formattedPrice = (dictionary[Client.Constants.SearchResults.FormattedPrice] as AnyObject!)!

    }

    static func SLOFromResults(results: [[String:AnyObject]]) -> [SearchResultsDict] {

        for result in results {

            if let studObjects = SearchResultsDict(dictionary: result) {

                searchResultsObjects.append(studObjects)
            }
        }
        return searchResultsObjects
    }










//        for result in results {
//
//            searchResultsObjDictionary["artistName"] = (result["artistName"])
//            searchResultsObjDictionary["bundleId"] = (result["bundleId"])
//            searchResultsObjDictionary["appId"] = (result["TrackId"])
//            searchResultsObjDictionary["releaseDate"] = (result["releaseDate"])
//            searchResultsObjDictionary["country"] = (result["country"])
//            searchResultsObjDictionary["language"] = (result["languageCodesISO2A"])
//            searchResultsObjDictionary["price"] = (result["formattedPrice"])
//
//
//            print(searchResultsObjDictionary)


}