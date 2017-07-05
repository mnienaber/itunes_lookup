//
//  DetailViewController.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/23/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class DetailViewController: UIViewController {

  var appDelegate: AppDelegate!
  var searchObject: SearchResultsDict?
  var shareableObject = [SearchResultsDict]()
  var trackIdText = String()
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var admobAd: GADBannerView!

  @IBOutlet weak var devLabel: UILabel!
  @IBOutlet weak var artistNameText: UITextField!
  @IBOutlet weak var bundleIdText: UITextField!
//    @IBOutlet weak var trackIdText: String!
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
//    @IBOutlet weak var descripTion: UITextField!

  @IBOutlet weak var descripTion: UITextView!
  @IBOutlet weak var backButton: UIBarButtonItem!
  @IBOutlet weak var kind: UITextField!
  @IBOutlet weak var contentRating: UITextField!
  @IBOutlet weak var features: UITextField!
  @IBOutlet weak var sellerName: UITextField!
  @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
//        admobAd.adUnitID = "ca-app-pub-6219811747049371/7793655040"
//        admobAd.rootViewController = self
//        admobAd.load(GADRequest())
        self.automaticallyAdjustsScrollViewInsets = false
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(searchObject)
        if let checkedUrl = URL(string: (searchObject?.artworkUrl60Text as? String)!) {

            imageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
    }

    override func viewWillAppear(_ animated: Bool) {

      if let object = searchObject {

          shareableObject = [object]

          artistNameText.isEnabled = false
//            bundleIdText.isEnabled = false
//            trackIdText.isEnabled = false
//            versionText.isEnabled = false
//            releaseDateText.isEnabled = false
//            currentVersionReleaseDateText.isEnabled = false
//            languageCodesISO2A.isEnabled = false
//            currencyText.isEnabled = false
//            primaryGenreName.isEnabled = false
//            minimumOsVersion.isEnabled = false
//            averageUserRatingForCurrentVersion.isEnabled = false
//            userRatingCount.isEnabled = false
          fileSizeBytes.isEnabled = false
//            supportedDevices.isEnabled = false
          formattedPriceText.isEnabled = false
//          descripTion.isEnabled = false
//            kind.isEnabled = false
//            contentRating.isEnabled = false
//            features.isEnabled = false
//            sellerName.isEnabled = false
//
          artistNameText.text = object.artistName as? String
//            bundleIdText.text = object.bundleId as? String
            trackIdText = object.trackId.description
//            versionText.text = object.version as? String
//            releaseDateText.text = object.releaseDate as? String
//            currentVersionReleaseDateText.text = object.currentVersionReleaseDate as? String
//            languageCodesISO2A.text = object.languageCodesISO2A.componentsJoined(by: ", ")
          formattedPriceText.text = object.formattedPrice as? String
//            currencyText.text = object.currency as? String
//            minimumOsVersion.text = object.minimumOsVersion as? String
//            primaryGenreName.text = object.primaryGenreName as? String
        averageUserRatingForCurrentVersion.text = object.averageUserRatingForCurrentVersion.description + "\u{2b50}"
          let fsize = ((object.fileSizeBytes).integerValue) / 1000000
          fileSizeBytes.text = String(describing: fsize) + "mb"
//            supportedDevices.text = object.supportedDevices.componentsJoined(by: ", ")
          descripTion.text = object.description as? String
//            userRatingCount.text = object.userRatingCount.description
//            kind.text = object.kind as? String
//            contentRating.text = object.trackContentRating as? String
//            features.text = object.features.componentsJoined(by: ", ")
//            sellerName.text = object.sellerName as? String
          navigationItem.title = object.trackName as? String
        }
    }

    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: URLProtectionSpace) -> Bool{
        print("canAuthenticateAgainstProtectionSpace method Returning True")
        return true
    }

    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: URLAuthenticationChallenge){

        print("did autherntcationchallenge = \(challenge.protectionSpace.authenticationMethod)")

        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust  {
            print("send credential Server Trust")
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            challenge.sender!.use(credential, for: challenge)

        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic{
            print("send credential HTTP Basic")
            let defaultCredentials: URLCredential = URLCredential(user: "username", password: "password", persistence:URLCredential.Persistence.forSession)
            challenge.sender!.use(defaultCredentials, for: challenge)

        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodNTLM{
            print("send credential NTLM")

        } else{
            challenge.sender!.performDefaultHandling!(for: challenge)
        }
    }
    
    @IBAction func moreButton(_ sender: AnyObject) {

      let app = UIApplication.shared
      app.openURL(NSURL(string: Client.Constants.Scheme.GoToApp + trackIdText)! as URL)
      print("off to iTunes")
    }

    @IBAction func backButton(_ sender: AnyObject) {

        self.navigationController?.popViewController(animated: true)
    }

  @IBAction func markButton(_ sender: Any) {
    print("markButton")

    markAlertGeneral(title: "Bookmark this app?", message: "", actionTitle: "Mark it!", cancelTitle: "Cancel")


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
      let urlRequest = NSURLRequest(url: url)
      let _ : NSURLConnection = NSURLConnection(request: urlRequest as URLRequest, delegate: self)!
      getDataFromUrl(url: url) { (data, response, error)  in

        DispatchQueue.main.sync() { () -> Void in
          print("starting")
          guard let data = data, error == nil else { return }
          print("ongoing")
          print(response?.suggestedFilename ?? url.lastPathComponent)
          print("Download Finished")
          self.activityIndicator.isHidden = true
          self.imageView.image = UIImage(data: data)
        }

      }
    }

}

extension DetailViewController {

  func markAlertGeneral(title: String, message: String, actionTitle: String, cancelTitle: String) {

    let markAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

    let actionTitle = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: {

      (actionTitle: UIAlertAction!) in
//
//      let app = App(appName: self.searchObject?.trackName, descriptionText: self.searchObject?.description, devName: self.searchObject?.artistName, fileSize: self.searchObject?.fileSizeBytes, image: imageView.image, price: self.searchObject?.formattedPrice
//        , rating: self.searchObject?.averageUserRatingForCurrentVersion, context: self.appDelegate.stack?.context)
      print("mark")
    })
    let cancelTitle = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: {

      (cancelTitle: UIAlertAction!) in print("cancel")
    })
      markAlertGeneral.addAction(actionTitle)
      markAlertGeneral.addAction(cancelTitle)
      self.present(markAlertGeneral, animated: true, completion: nil)
  }
}
