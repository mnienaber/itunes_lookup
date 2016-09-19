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
    let artistId: AnyObject
    let bundleId: AnyObject
    let trackId: AnyObject
    let releaseDate: AnyObject
    let currency: AnyObject
    let languageCodesISO2A: [AnyObject]
    let formattedPrice: AnyObject
    let currentVersionReleaseDate: AnyObject
//    let averageUserRating: AnyObject
    let artworkUrl60: AnyObject
    let version: AnyObject
    //let trackName: AnyObject
    let primaryGenreName: AnyObject
    let description: AnyObject
    let minimumOsVersion: AnyObject
    let userRatingCountForCurrentVersion: AnyObject
    let userRatingCount: AnyObject
    let fileSizeBytes: AnyObject
    let supportedDevices: AnyObject


    init?(dictionary: [String: AnyObject]) {

        guard let aName = (dictionary[Client.Constants.SearchResults.ArtistName] as AnyObject!) else { return nil }
        artistName = aName
        guard let aId = (dictionary[Client.Constants.SearchResults.ArtistId] as AnyObject!) else { return nil }
        artistId = aId
        guard let bId = (dictionary[Client.Constants.SearchResults.BundleId] as AnyObject!) else { return nil }
        bundleId = bId
        guard let tId = (dictionary[Client.Constants.SearchResults.TrackId] as AnyObject!) else { return nil }
        trackId = tId
        guard let rDate = (dictionary[Client.Constants.SearchResults.ReleaseDate] as AnyObject!) else { return nil }
        releaseDate = rDate
        guard let c = (dictionary[Client.Constants.SearchResults.currency] as AnyObject!) else { return nil }
        currency = c
        guard let lCodesISO2A = (dictionary[Client.Constants.SearchResults.languageCodesISO2A] as! [AnyObject]!) else { return nil }
        languageCodesISO2A = lCodesISO2A
        guard let fPrice = (dictionary[Client.Constants.SearchResults.FormattedPrice] as AnyObject!) else { return nil }
        formattedPrice = fPrice
        guard let cVersionReleaseDate = (dictionary[Client.Constants.SearchResults.CurrentVersionReleaseDate] as AnyObject!) else { return nil }
        currentVersionReleaseDate = cVersionReleaseDate
        guard let aUrl60 = (dictionary[Client.Constants.SearchResults.ArtworkUrl60] as AnyObject!) else { return nil }
        artworkUrl60 = aUrl60
        guard let v = (dictionary[Client.Constants.SearchResults.Version] as AnyObject!) else { return nil }
        version = v
        guard let uRatingCount = (dictionary[Client.Constants.SearchResults.UserRatingCount] as AnyObject!) else { return nil }
        userRatingCount = uRatingCount
        guard let uRatingCountForCurrentVersion = (dictionary[Client.Constants.SearchResults.UserRatingCountForCurrentVersion] as AnyObject!) else { return nil }
        userRatingCountForCurrentVersion = uRatingCountForCurrentVersion
        guard let mOsVersion = (dictionary[Client.Constants.SearchResults.MinimumOsVersion] as AnyObject!) else { return nil }
        minimumOsVersion = mOsVersion
        guard let pGenreName = (dictionary[Client.Constants.SearchResults.PrimaryGenreName] as AnyObject!) else { return nil }
        primaryGenreName = pGenreName
        guard let d = (dictionary[Client.Constants.SearchResults.Description] as AnyObject!) else { return nil }
        description = d
        guard let fSizeBytes = (dictionary[Client.Constants.SearchResults.FileSizeBytes] as AnyObject!) else { return nil }
        fileSizeBytes = fSizeBytes
        guard let sDevices = (dictionary[Client.Constants.SearchResults.SupportedDevices] as AnyObject!) else { return nil }
        supportedDevices = sDevices

    }

    static func SLOFromResults(_ results: [[String:AnyObject]]) -> [SearchResultsDict] {

        for result in results {

            searchResultsObjects.append(SearchResultsDict(dictionary: result)!)
        }
        return searchResultsObjects
    }
}
