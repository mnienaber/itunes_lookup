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
    let searchObject: SearchResultsDict? = nil

    @IBOutlet weak var artistNameText: UITextView!
    @IBOutlet weak var bundleIdText: UITextView!
    @IBOutlet weak var appIdText: UITextView!
    @IBOutlet weak var releaseDateText: UITextView!
    @IBOutlet weak var currentVersionReleaseDateText: UITextView!
    @IBOutlet weak var languageCodesISO2A: UITextView!
    @IBOutlet weak var formattedPriceText: UITextView!
    @IBOutlet weak var currencyText: UITextView!
    @IBOutlet weak var versionText: UITextView!
    @IBOutlet weak var artworkUrl60Text: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


    }

    override func viewWillAppear(animated: Bool) {

        if let searchResults = searchObject {

            //artistNameText.text = searchResults.artistName as! String
            artistNameText.text = "fucker"
            bundleIdText.text = searchResults.bundleId as! String
            appIdText.text = searchResults.appId as! String
            releaseDateText.text = searchResults.releaseDate as! String


            currentVersionReleaseDateText.text = searchResults.currentVersionReleaseDate as! String
            languageCodesISO2A.text = searchResults.languageCodesISO2A as! String
            formattedPriceText.text = searchResults.formattedPrice as! String
            currencyText.text = searchResults.currency as! String
            versionText.text = searchResults.version as! String
            artworkUrl60Text.text = searchResults.artworkUrl60 as! String
            
        }
    }

    
}