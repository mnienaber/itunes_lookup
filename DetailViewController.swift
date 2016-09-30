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
    var shareableObject = [SearchResultsDict]()

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
    @IBOutlet weak var artistID: UITextField!
    @IBOutlet weak var descripTion: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        appDelegate = UIApplication.shared.delegate as! AppDelegate


    }

    override func viewWillAppear(_ animated: Bool) {

        if let object = searchObject {

            shareableObject = [object]

            artistNameText.isEnabled = false
            bundleIdText.isEnabled = false
            trackIdText.isEnabled = false
            releaseDateText.isEnabled = false
            currentVersionReleaseDateText.isEnabled = false
            languageCodesISO2A.isEnabled = false
            formattedPriceText.isEnabled = false
            currencyText.isEnabled = false
            versionText.isEnabled = false
            minimumOsVersion.isEnabled = false
            primaryGenreName.isEnabled = false
            userRatingCountForCurrentVersion.isEnabled = false
            fileSizeBytes.isEnabled = false
            supportedDevices.isEnabled = false

            artistNameText.text = object.artistName as? String
            bundleIdText.text = object.bundleId as? String
            trackIdText.text = object.trackId as? String
            //artistID.text = object.artistId as? String
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
            //descripTion.text = object.description as? String
            
        }
    }

    @IBAction func shareButton(_ sender: AnyObject) {

        print("thisis \(shareableObject) this is the end")


        let activityView = UIActivityViewController(activityItems: shareableObject, applicationActivities: nil)
        self.present(activityView, animated: true, completion: nil)
    }
}
