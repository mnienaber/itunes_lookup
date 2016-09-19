//
//  DetailViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/23/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var appDelegate: AppDelegate!
    var searchObject: SearchResultsDict?

    @IBOutlet weak var artistNameText: UILabel!
    @IBOutlet weak var bundleIdText: UILabel!
    @IBOutlet weak var trackIdText: UILabel!
    @IBOutlet weak var releaseDateText: UILabel!
    @IBOutlet weak var currentVersionReleaseDateText: UILabel!
    @IBOutlet weak var languageCodesISO2A: UILabel!
    @IBOutlet weak var formattedPriceText: UILabel!
    @IBOutlet weak var currencyText: UILabel!
    @IBOutlet weak var versionText: UILabel!
    @IBOutlet weak var artworkUrl60Text: UILabel!
    @IBOutlet weak var artistID: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate


    }

    override func viewWillAppear(_ animated: Bool) {

        if let object = searchObject {

            artistNameText.text = object.artistName as? String
            bundleIdText.text = object.bundleId as? String
            trackIdText.text = object.trackId as? String
            artistID.text = object.artistId as? String
            releaseDateText.text = object.releaseDate as? String
            currentVersionReleaseDateText.text = object.currentVersionReleaseDate as? String
            languageCodesISO2A.text = object.languageCodesISO2A as? String
            formattedPriceText.text = object.formattedPrice as? String
            currencyText.text = object.currency as? String
            versionText.text = object.version as? String
            artworkUrl60Text.text = object.artworkUrl60 as? String
            
        }
    }

    
}
