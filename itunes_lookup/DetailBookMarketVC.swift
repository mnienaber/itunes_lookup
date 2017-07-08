//
//  DetailBookMarketVC.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 7/9/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

class DetailBookMarkedVC: UIViewController {

  var detailApp = App()
  var shareableApp = [App]()

  @IBOutlet weak var artistNameText: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var size: UITextField!
  @IBOutlet weak var price: UITextField!
  @IBOutlet weak var rating: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    activityIndicator.isHidden = false
    artistNameText.isEnabled = false
    size.isEnabled = false
    rating.isEnabled = false
    price.isEnabled = false

    print("detailApp: \(detailApp)")
  }
}
