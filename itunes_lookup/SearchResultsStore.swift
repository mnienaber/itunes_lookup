//
//  SearchResultsStore.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 9/1/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsStore: UIViewController {

    var searchResults = [SearchResultsDict]()
    var developerResults = [SearchResultsDict]()

    class func sharedInstance() -> SearchResultsStore {
        struct Singleton {
            static var sharedInstance = SearchResultsStore()
        }
        return Singleton.sharedInstance
    }
}
