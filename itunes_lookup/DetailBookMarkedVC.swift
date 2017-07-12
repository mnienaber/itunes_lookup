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
  var shareableApp = [App]()
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
    print("here i am: \(detailApp)")

//    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "App")
//    fr.predicate = NSPredicate(format: "appName = %@", appNameString)
//    //fr.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//    fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: self.delegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
//  }

  func viewWillAppear(_ animated: Bool) {
    activityIndicator.isHidden = false
    artistNameText.isEnabled = false
    size.isEnabled = false
    rating.isEnabled = false
    price.isEnabled = false

    print("detailApp: \(detailApp.appName)")
  }
}
}
