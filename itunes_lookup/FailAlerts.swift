//
//  FailAlerts.swift
//  virtual_tourist
//
//  Created by Michael Nienaber on 3/15/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

class FailAlerts: UIViewController {

  func failGenOK(title: String, message: String, alerttitle: String, cancelTitle: String) {

    let failLoginAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    failLoginAlert.addAction(UIAlertAction(title: alerttitle, style: UIAlertActionStyle.default, handler: nil))
    failLoginAlert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: nil))
    self.present(failLoginAlert, animated: true, completion: nil)
    
  }

  func failSmallOK(title: String, message: String, alerttitle: String) {

    let failLoginAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    failLoginAlert.addAction(UIAlertAction(title: alerttitle, style: UIAlertActionStyle.default, handler: nil))
    self.present(failLoginAlert, animated: true, completion: nil)
  }

  func failAlertGeneral(title: String, message: String, actionTitle: String) {

    let failAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    failAlertGeneral.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil))
    self.present(failAlertGeneral, animated: true, completion: nil)
  }

//  func alreadyGotAlert(title: String, message: String, cancelTitle: String) {
//
//    print("here i am")
//
//    let markAlertGeneral = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
//    let cancelTitle = UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: {
//
//      (cancelTitle: UIAlertAction!) in print("Got it")
//    })
//    markAlertGeneral.addAction(cancelTitle)
//    self.present(markAlertGeneral, animated: true, completion: nil)
//  }
}

extension FailAlerts {

  class func sharedInstance() -> FailAlerts {
    struct Singleton {
      static var sharedInstance = FailAlerts()
    }
    return Singleton.sharedInstance
  }
}
