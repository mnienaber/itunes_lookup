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

  var detailApp = App()
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
    print("here i am: \(detailApp.appName))")
    let app = NSEntityDescription.insertNewObject(forEntityName: "App", into: self.delegate.stack.context) as? App
    print(app)
//      descriptionText.text = detailApp.descriptionText! + "\u{2b50}"
//      imageView.image = UIImage(data: detailApp.image!)
//      size.text = String(describing: detailApp.fileSize) + "mb"
//      price.text = detailApp.price
//      rating.text = detailApp.rating as? String
//      artistNameText.text = detailApp.appName
    }


  override func viewWillAppear(_ animated: Bool) {
    artistNameText.isEnabled = false
    size.isEnabled = false
    rating.isEnabled = false
    price.isEnabled = false

    print("detailApp: \(detailApp)")


  }
}
