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

    @IBOutlet weak var devLabel: UILabel!
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
    @IBOutlet weak var descripTion: UITextField!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var placeHolder: UITextField!
    @IBOutlet weak var placeHolderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        //devLabel.GMDIcon = GMDType.GMDPublic
    }

    override func viewWillAppear(_ animated: Bool) {

        if let object = searchObject {

            shareableObject = [object]

            artistNameText.isEnabled = false
            bundleIdText.isEnabled = false
            trackIdText.isEnabled = false
            versionText.isEnabled = false
            releaseDateText.isEnabled = false
            currentVersionReleaseDateText.isEnabled = false
            languageCodesISO2A.isEnabled = false
            currencyText.isEnabled = false
            primaryGenreName.isEnabled = false
            minimumOsVersion.isEnabled = false
            userRatingCountForCurrentVersion.isEnabled = false
            userRatingCount.isEnabled = false
            fileSizeBytes.isEnabled = false
            supportedDevices.isEnabled = false
            formattedPriceText.isEnabled = false
            descripTion.isEnabled = false
            //placeHolder.isEnabled = false

            artistNameText.text = object.artistName as? String
            bundleIdText.text = object.bundleId as? String
            trackIdText.text = object.trackId.description
            versionText.text = object.version as? String
            releaseDateText.text = object.releaseDate as? String
            currentVersionReleaseDateText.text = object.currentVersionReleaseDate as? String
            languageCodesISO2A.text = object.languageCodesISO2A.componentsJoined(by: ", ")
            formattedPriceText.text = object.formattedPrice as? String
            currencyText.text = object.currency as? String
            minimumOsVersion.text = object.minimumOsVersion as? String
            primaryGenreName.text = object.primaryGenreName as? String
            userRatingCountForCurrentVersion.text = object.userRatingCountForCurrentVersion.description
            fileSizeBytes.text = object.fileSizeBytes as? String
            supportedDevices.text = object.supportedDevices.componentsJoined(by: ", ")
            descripTion.text = object.description as? String
            navigationItem.title = object.trackName as? String
        }
    }
    
    @IBAction func moreButton(_ sender: AnyObject) {

        let plusInsert = artistNameText.text!.components(separatedBy: " ")
        let realSearchText = plusInsert.joined(separator: "+")

        print(realSearchText)

        Client.sharedInstance().getSearchItems(realSearchText) { (searchResultsDict, error) in

            if error != nil {

                self.failAlertGeneral(title: "Error", message: "Seems to be an error with your query", actionTitle: "Try Again")
            } else if searchResultsDict?.count == 0 {

                self.failAlertGeneral(title: "No Results", message: "That Was Unique! Try Another Search Term", actionTitle: "OK")
            } else {

                if let searchResultsDict = searchResultsDict {

                    print(searchResultsDict)

                    performUIUpdatesOnMain {

                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DevViewController") as? DevViewController
                        self.navigationController!.pushViewController(controller!, animated: true)
                    }
                }
            }
        }
    }

    @IBAction func backButton(_ sender: AnyObject) {

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func shareButton(_ sender: AnyObject) {

        let shareDict = SearchResultsStore.sharedInstance().searchResults

        let activityView = UIActivityViewController(activityItems: [shareDict], applicationActivities: nil)
        self.present(activityView, animated: true, completion: nil)

    }
}

extension DetailViewController {

    func failAlertGeneral(title: String, message: String, actionTitle: String) {

        let failAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        failAlertGeneral.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(failAlertGeneral, animated: true, completion: nil)
    }
}
