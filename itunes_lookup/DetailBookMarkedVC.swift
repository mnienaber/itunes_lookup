//
//  DetailBookMarketVC.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 7/9/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailBookMarkedVC: UIViewController {

  var appNameString = String()
  let delegate = UIApplication.shared.delegate as! AppDelegate

  @IBOutlet weak var descriptionText: UITextView!
  @IBOutlet weak var artistNameText: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var size: UITextField!
  @IBOutlet weak var price: UITextField!
  @IBOutlet weak var rating: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


  override func viewDidLoad() {
    super.viewDidLoad()

    let app = Client.sharedInstance().segueApp.first
    descriptionText.text = (app?.descriptionText!)!
    let fsize = ((app?.fileSize)?.integerValue)! / 1000000
    size.text = String(describing: fsize) + "mb"
    price.text = app?.price
    rating.text = (app?.rating?.description)! + "\u{2b50}"
    artistNameText.text = app?.appName
    activityIndicator.isHidden = true

    if app?.image == nil {
      imageView.image = UIImage(named: "no_image_placeholder")
    } else {
      self.imageView.image = UIImage(data: (app?.image)!)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    artistNameText.isEnabled = false
    size.isEnabled = false
    rating.isEnabled = false
    price.isEnabled = false

  }
  @IBAction func downLoadButton(_ sender: Any) {

    if let url = URL(string: (Client.sharedInstance().segueApp.first?.url)! as! String){
      print(url)
      UIApplication.shared.openURL(url)
    }
    print("off to iTunes")
  }
}
