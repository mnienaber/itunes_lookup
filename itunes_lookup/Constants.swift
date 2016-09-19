//
//  Constants.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/17/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

extension Client {

    struct Constants {

        struct Scheme {

            static let SearchMethod = "https://itunes.apple.com/search?term="
            static let LookUpMethod = "https://itunes.apple.com/lookup?id="
            static let limitAndApp = "&&entity=software"
        }

        struct SearchResults {

            static let ArtistName = "artistName"
            static let ArtistId = "artistId"
            static let BundleId = "bundleId"
            static let TrackId = "trackId"
            static let ReleaseDate = "releaseDate"
            static let country = "country"
            static let currency = "currency"
            static let languageCodesISO2A = "languageCodesISO2A"
            static let FormattedPrice = "formattedPrice"
            static let CurrentVersionReleaseDate = "currentVersionReleaseDate"
            static let ArtworkUrl60 = "artworkUrl60"
            static let MinimumOsVersion = "minimumOsVersion"
            static let PrimaryGenreName = "primaryGenreName"
            static let Description = "description"
            static let UserRatingCount = "userRatingCount"
            static let Version = "version"
            static let UserRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
            static let FileSizeBytes = "fileSizeBytes"
            static let SupportedDevices = "supportedDevices"
        }
    }
}
