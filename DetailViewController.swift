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

    @IBOutlet weak var artistNameText: UITextField!
    @IBOutlet weak var bundleIdText: UITextField!
    @IBOutlet weak var trackIdText: UITextField!
    @IBOutlet weak var releaseDateText: UITextField!
    @IBOutlet weak var currentVersionReleaseDateText: UITextField!
    @IBOutlet weak var languageCodesISO2A: UITextField!
    @IBOutlet weak var formattedPriceText: UITextField!
    @IBOutlet weak var currencyText: UITextField!
    @IBOutlet weak var versionText: UITextField!
    @IBOutlet weak var artworkUrl60Text: UITextField!
    @IBOutlet weak var userRatingCountForCurrentVersion: UITextField!
    @IBOutlet weak var minimumOsVersion: UITextField!
    @IBOutlet weak var primaryGenreName: UITextField!
    @IBOutlet weak var userRatingCount: UITextField!
    @IBOutlet weak var fileSizeBytes: UITextField!
    @IBOutlet weak var supportedDevices: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        appDelegate = UIApplication.shared.delegate as! AppDelegate


    }

    override func viewWillAppear(_ animated: Bool) {

        if let object = searchObject {

            artistNameText.text = object.artistName as? String
            bundleIdText.text = object.bundleId as? String
            trackIdText.text = object.trackId as? String
            //artistID.text = object.artistId as? AnyObject
            releaseDateText.text = object.releaseDate as? String
            currentVersionReleaseDateText.text = object.currentVersionReleaseDate as? String
            languageCodesISO2A.text = object.languageCodesISO2A as? String
            formattedPriceText.text = object.formattedPrice as? String
            currencyText.text = object.currency as? String
            versionText.text = object.version as? String
            minimumOsVersion.text = object.minimumOsVersion as? String
            primaryGenreName.text = object.primaryGenreName as? String
            userRatingCountForCurrentVersion.text = object.userRatingCountForCurrentVersion as? String
            fileSizeBytes.text = object.fileSizeBytes as? String
            supportedDevices.text = object.supportedDevices as? String
            
        }
    }

}
