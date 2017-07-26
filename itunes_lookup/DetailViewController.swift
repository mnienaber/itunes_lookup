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
import CoreData

class DetailViewController: UIViewController {

  var appDelegate: AppDelegate!
  var searchObject: SearchResultsDict?
  var shareableObject = [SearchResultsDict]()
  var trackIdText = String()
  var image = Data()
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBOutlet weak var admobAd: GADBannerView!

  @IBOutlet weak var markButtonOutlet: UIButton!
  @IBOutlet weak var devLabel: UILabel!
  @IBOutlet weak var artistNameText: UITextField!
  @IBOutlet weak var bundleIdText: UITextField!
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
      activityIndicator.startAnimating()
      self.automaticallyAdjustsScrollViewInsets = false
      appDelegate = UIApplication.shared.delegate as! AppDelegate

      if let checkedUrl = URL(string: (searchObject?.artworkUrl60Text as? String)!) {

          imageView.contentMode = .scaleAspectFit
          downloadImage(url: checkedUrl)
      }
  }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)

      if let object = searchObject {

        shareableObject = [object]

        artistNameText.isEnabled = false
        fileSizeBytes.isEnabled = false
        formattedPriceText.isEnabled = false//
        artistNameText.text = object.artistName as? String
          trackIdText = object.trackId.description
        formattedPriceText.text = object.formattedPrice as? String
        averageUserRatingForCurrentVersion.text = object.averageUserRatingForCurrentVersion.description + "\u{2b50}"
        let fsize = ((object.fileSizeBytes).integerValue) / 1000000
        fileSizeBytes.text = String(describing: fsize) + "mb"
        descripTion.text = object.description as? String
        navigationItem.title = object.trackName as? String
      }

      if App.coreAppWithNetworkInfo(appInfo: navigationItem.title!, inManagedObjectContext: appDelegate.stack.context) == 0 {
        markButtonOutlet.setTitle("Mark", for: .normal)
      } else {
        markButtonOutlet.setTitle("You got this!", for: .normal)
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
    let shareDict = SearchResultsStore.sharedInstance().searchResults
    print(shareDict)

    if App.coreAppWithNetworkInfo(appInfo: navigationItem.title!, inManagedObjectContext: appDelegate.stack.context) == 0 {

      markAlertGeneral(title: "Bookmark this app?", message: "", actionTitle: "Mark it!", cancelTitle: "Cancel")
      markButtonOutlet.setTitle("Saved!", for: .normal)

    } else {
      alreadyGotAlert(title: "You already got this one!", message: "Check your bookmark list", cancelTitle: "Got it")
      markButtonOutlet.setTitle("Saved!", for: .normal)
      print("alert")
    }
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
          self.activityIndicator.stopAnimating()
          self.image = data
          self.imageView.image = UIImage(data: self.image)
        }

      }
    }

}

extension DetailViewController {

  func markAlertGeneral(title: String, message: String, actionTitle: String, cancelTitle: String) {

    let markAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

    let actionTitle = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: {

      (actionTitle: UIAlertAction!) in

      let app = App(appName: self.searchObject?.trackName as! String,
              descriptionText: self.searchObject?.description as! String,
              devName: self.searchObject?.artistName as! String,
              fileSize: (self.searchObject?.fileSizeBytes)!,
              image: self.image,
              price: self.searchObject?.formattedPrice as! String,
              rating: self.searchObject?.averageUserRatingForCurrentVersion as AnyObject,
              url: self.searchObject?.trackViewUrl as AnyObject,
              context: self.appDelegate.stack.context)
      print(app)
      print(self.appDelegate.stack.context)
      self.appDelegate.stack.save()
    })
    let cancelTitle = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: {

      (cancelTitle: UIAlertAction!) in print("cancel")
    })
      markAlertGeneral.addAction(actionTitle)
      markAlertGeneral.addAction(cancelTitle)
      self.present(markAlertGeneral, animated: true, completion: nil)
  }

  func alreadyGotAlert(title: String, message: String, cancelTitle: String) {

    let markAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

    let cancelTitle = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: {

      (cancelTitle: UIAlertAction!) in print("Got it")
    })
    markAlertGeneral.addAction(cancelTitle)
    self.present(markAlertGeneral, animated: true, completion: nil)
  }
}
