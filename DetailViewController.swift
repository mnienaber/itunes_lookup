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
    @IBOutlet weak var averageUserRatingForCurrentVersion: UITextField!
    @IBOutlet weak var minimumOsVersion: UITextField!
    @IBOutlet weak var primaryGenreName: UITextField!
    @IBOutlet weak var userRatingCount: UITextField!
    @IBOutlet weak var fileSizeBytes: UITextField!
    @IBOutlet weak var supportedDevices: UITextField!
    @IBOutlet weak var descripTion: UITextField!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var placeHolder: UITextField!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var kind: UITextField!
    @IBOutlet weak var contentRating: UITextField!
    @IBOutlet weak var features: UITextField!
    @IBOutlet weak var sellerName: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    //@IBOutlet weak var descripTion: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let checkedUrl = URL(string: "http://www.pngmart.com/files/2/Mario-Transparent-Background.png") {

            imageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
            print(checkedUrl)
        }


        //navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "SF-UI-Text-Bold", size: 34)! ]
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
            averageUserRatingForCurrentVersion.isEnabled = false
            userRatingCount.isEnabled = false
            fileSizeBytes.isEnabled = false
            supportedDevices.isEnabled = false
            formattedPriceText.isEnabled = false
            descripTion.isEnabled = false
            kind.isEnabled = false
            contentRating.isEnabled = false
            features.isEnabled = false
            sellerName.isEnabled = false

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
            averageUserRatingForCurrentVersion.text = object.averageUserRatingForCurrentVersion.description
            let fsize = ((object.fileSizeBytes).integerValue) / 1000000
            print(fsize)
            fileSizeBytes.text = String(describing: fsize) + " mb"
            supportedDevices.text = object.supportedDevices.componentsJoined(by: ", ")
            descripTion.text = object.description as? String
            userRatingCount.text = object.userRatingCount.description
            kind.text = object.kind as? String
            contentRating.text = object.trackContentRating as? String
            features.text = object.features.componentsJoined(by: ", ")
            sellerName.text = object.sellerName as? String
            navigationItem.title = object.trackName as? String
        }
    }
    
    @IBAction func moreButton(_ sender: AnyObject) {

        let app = UIApplication.shared
        app.openURL(NSURL(string: Client.Constants.Scheme.GoToApp + trackIdText.text!)! as URL)
    }

    @IBAction func backButton(_ sender: AnyObject) {

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func shareButton(_ sender: AnyObject) {

        let shareDict = SearchResultsStore.sharedInstance().searchResults

        let activityView = UIActivityViewController(activityItems: [shareDict], applicationActivities: nil)
        self.present(activityView, animated: true, completion: nil)
    }

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }

    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            DispatchQueue.main.sync() { () -> Void in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                self.imageView.image = UIImage(data: data)
            }
        }
    }
}

extension DetailViewController {

    func failAlertGeneral(title: String, message: String, actionTitle: String) {

        let failAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        failAlertGeneral.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(failAlertGeneral, animated: true, completion: nil)
    }
}
