//
//  SearchResultsObject.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/17/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

//var searchResultsObjects = [SearchResultsDict]()
//var searchResultsObjDictionary = [String: AnyObject]()

struct SearchResultsDict {

    let artistName: AnyObject
    let bundleId: AnyObject
    let trackId: AnyObject
    let version: AnyObject
    let releaseDate: AnyObject
    let currentVersionReleaseDate: AnyObject
    let languageCodesISO2A: AnyObject
    let currency: AnyObject
    let primaryGenreName: AnyObject
    let minimumOsVersion: AnyObject
    let averageUserRatingForCurrentVersion: AnyObject
    let userRatingCount: AnyObject
    let fileSizeBytes: AnyObject
    let supportedDevices: AnyObject
    let formattedPrice: AnyObject
    let description: AnyObject
    let trackName: AnyObject
    let kind: AnyObject
    let trackContentRating: AnyObject
    let features: AnyObject
    let sellerName: AnyObject
    let artworkUrl60Text: AnyObject

    init?(dictionary: [String: AnyObject]) {

        guard let aName = (dictionary[Client.Constants.SearchResults.ArtistName] as AnyObject!) else { return nil }
        artistName = aName
        guard let bId = (dictionary[Client.Constants.SearchResults.BundleId] as AnyObject!) else { return nil }
        bundleId = bId

        guard let rDate = (dictionary[Client.Constants.SearchResults.ReleaseDate] as AnyObject!) else { return nil }
        releaseDate = rDate
        guard let c = (dictionary[Client.Constants.SearchResults.currency] as AnyObject!) else { return nil }
        currency = c
        guard let lCodesISO2A = (dictionary[Client.Constants.SearchResults.languageCodesISO2A] as AnyObject!) else { return nil }
        languageCodesISO2A = lCodesISO2A
        guard let fPrice = (dictionary[Client.Constants.SearchResults.FormattedPrice] as AnyObject!) else { return nil }
        formattedPrice = fPrice
        guard let cVersionReleaseDate = (dictionary[Client.Constants.SearchResults.CurrentVersionReleaseDate] as AnyObject!) else { return nil }
        currentVersionReleaseDate = cVersionReleaseDate
        guard let v = (dictionary[Client.Constants.SearchResults.Version] as AnyObject!) else { return nil }
        version = v
        guard let uRatingCount = (dictionary[Client.Constants.SearchResults.UserRatingCount] as AnyObject!) else { return nil }
        userRatingCount = uRatingCount
        guard let uRatingCountForCurrentVersion = (dictionary[Client.Constants.SearchResults.AverageUserRatingForCurrentVersion] as AnyObject!) else { return nil }
        averageUserRatingForCurrentVersion = uRatingCountForCurrentVersion
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
        guard let trNm = (dictionary[Client.Constants.SearchResults.TrackName] as AnyObject!) else { return nil }
        trackName = trNm
        guard let trId = (dictionary[Client.Constants.SearchResults.TrackId] as AnyObject!) else { return nil }
        trackId = trId
        guard let knd = (dictionary[Client.Constants.SearchResults.Kind] as AnyObject!) else { return nil }
        kind = knd
        guard let tContentRating = (dictionary[Client.Constants.SearchResults.TrackContentRating] as AnyObject!) else { return nil }
        trackContentRating = tContentRating
        guard let ftures = (dictionary[Client.Constants.SearchResults.Features] as AnyObject!) else { return nil }
        features = ftures
        guard let sName = (dictionary[Client.Constants.SearchResults.SellerName] as AnyObject!) else { return nil }
        sellerName = sName
        guard let art = (dictionary[Client.Constants.SearchResults.ArtworkUrl60] as AnyObject!) else { return nil }
        artworkUrl60Text = art
    }

    static func SLOFromResults(results: [[String:AnyObject]]) -> [SearchResultsDict] {

        for result in results {

            if let searchObjects = SearchResultsDict(dictionary: result) {

                SearchResultsStore.sharedInstance().searchResults.append(searchObjects)
            }
        }
        return SearchResultsStore.sharedInstance().searchResults
    }
}
